#!/usr/bin/env python3
"""Offline synthesis of the C Aegean handpan's 9 tone-field samples.

Pure standard library (wave/array/math/random) - no numpy/scipy needed.
Each note is additive sine partials (fundamental + inharmonic overtones)
with an exponential decay envelope, plus a short filtered-noise strike
transient. This mirrors the recipe used in the original Web Audio
prototype, minus the reverb tail: reverb here is handled live in-app by
flutter_soloud's Freeverb filter, so these renders stay dry.

Run: python3 tool/generate_audio.py
Output: assets/audio/note_<key>.wav (mono, 16-bit PCM, 44.1kHz)
"""

import math
import os
import random
import struct
import wave

SAMPLE_RATE = 44100
OUT_DIR = os.path.join(os.path.dirname(__file__), "..", "assets", "audio")

# (asset key, frequency in Hz, is_ding)
NOTES = [
    ("ding", 130.813, True),   # C3
    ("1", 164.814, False),     # E3
    ("2", 195.998, False),     # G3
    ("3", 246.942, False),     # B3
    ("4", 261.626, False),     # C4
    ("5", 329.628, False),     # E4
    ("6", 369.994, False),     # F#4
    ("7", 391.995, False),     # G4
    ("8", 493.883, False),     # B4
]

# (frequency ratio, peak gain, decay-time multiplier of the note's base decay)
PARTIALS = [
    (1.0, 0.90, 1.00),
    (2.0, 0.30, 0.72),
    (3.005, 0.13, 0.55),  # slightly detuned -> slow shimmer/beating
    (4.0, 0.055, 0.32),
]

ATTACK_SECONDS = 0.006
NOISE_SECONDS = 0.08
NOISE_GAIN = 0.16
NOISE_DECAY = 0.06
DECAY_EXPONENT = 6.0  # higher = faster perceived fade-out


def render_note(freq: float, is_ding: bool) -> list[float]:
    base_decay = 4.6 if is_ding else 3.5
    duration = base_decay + 0.3
    n = int(SAMPLE_RATE * duration)
    dt = 1.0 / SAMPLE_RATE
    buf = [0.0] * n
    attack_n = max(1, int(SAMPLE_RATE * ATTACK_SECONDS))

    for ratio, gain, decay_mult in PARTIALS:
        decay = base_decay * decay_mult
        omega = 2.0 * math.pi * freq * ratio
        for i in range(n):
            t = i * dt
            if i < attack_n:
                env = gain * (i / attack_n)
            else:
                env = gain * math.exp(-DECAY_EXPONENT * t / decay)
            buf[i] += env * math.sin(omega * t)

    # Short filtered-noise strike transient: white noise -> one-pole
    # highpass (kills DC/rumble) -> one-pole lowpass (tames harsh hiss).
    noise_n = int(SAMPLE_RATE * NOISE_SECONDS)
    raw = [random.uniform(-1.0, 1.0) for _ in range(noise_n)]
    hp = [raw[i] - (raw[i - 1] if i > 0 else 0.0) for i in range(noise_n)]
    smoothing = 0.6
    prev = 0.0
    for i in range(noise_n):
        prev = smoothing * prev + (1.0 - smoothing) * hp[i]
        t = i * dt
        env = NOISE_GAIN * math.exp(-DECAY_EXPONENT * t / NOISE_DECAY)
        buf[i] += env * prev

    peak = max((abs(x) for x in buf), default=1.0) or 1.0
    scale = min(1.0, 0.92 / peak)
    return [x * scale for x in buf]


def write_wav(path: str, samples: list[float]) -> None:
    frames = struct.pack(
        "<%dh" % len(samples),
        *(int(max(-1.0, min(1.0, s)) * 32767) for s in samples),
    )
    with wave.open(path, "w") as f:
        f.setnchannels(1)
        f.setsampwidth(2)
        f.setframerate(SAMPLE_RATE)
        f.writeframes(frames)


def main() -> None:
    os.makedirs(OUT_DIR, exist_ok=True)
    for key, freq, is_ding in NOTES:
        samples = render_note(freq, is_ding)
        out_path = os.path.join(OUT_DIR, f"note_{key}.wav")
        write_wav(out_path, samples)
        print(f"wrote {out_path} ({len(samples) / SAMPLE_RATE:.2f}s)")


if __name__ == "__main__":
    main()
