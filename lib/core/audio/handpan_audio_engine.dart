import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import '../constants/tone_field_catalog.dart';

/// Loads the 9 pre-rendered tone-field samples once and plays them with
/// low-latency polyphony, so several fields struck at once (a chord) all
/// ring out together. Reverb is a live global filter rather than baked
/// into the samples, so the "resonance" toggle is instant.
class HandpanAudioEngine extends ChangeNotifier {
  final SoLoud _soloud = SoLoud.instance;
  final Map<String, AudioSource> _sources = {};
  bool _ready = false;

  double _volume = 0.85;
  bool _reverbEnabled = true;

  double get volume => _volume;
  bool get reverbEnabled => _reverbEnabled;
  bool get isReady => _ready;

  Future<void> init() async {
    if (_ready) return;
    await _soloud.init();
    for (final field in toneFieldCatalog) {
      _sources[field.key] = await _soloud.loadAsset(field.assetPath);
    }
    _soloud.setGlobalVolume(_volume);
    _applyReverb();
    // Always-on safety net: several tone fields struck at once, plus a
    // wide reverb tail, can otherwise sum past 0dB and clip into a harsh,
    // "tearing" distortion.
    // ignore: experimental_member_use
    final limiter = _soloud.filters.limiterFilter;
    if (!limiter.isActive) limiter.activate();
    limiter.threshold.value = -6;
    limiter.outputCeiling.value = -1;
    _ready = true;
  }

  void strike(String fieldKey) {
    if (!_ready) return;
    final source = _sources[fieldKey];
    if (source == null) return;
    unawaited(_soloud.play(source));
  }

  void setVolume(double value) {
    _volume = value.clamp(0.0, 1.0).toDouble();
    if (_ready) _soloud.setGlobalVolume(_volume);
    notifyListeners();
  }

  void setReverbEnabled(bool enabled) {
    _reverbEnabled = enabled;
    if (_ready) _applyReverb();
    notifyListeners();
  }

  void _applyReverb() {
    final reverb = _soloud.filters.freeverbFilter;
    if (_reverbEnabled) {
      if (!reverb.isActive) reverb.activate();
      // A noticeable but controlled room - pushed further and the wet
      // signal starts summing past 0dB with the limiter, which reads as
      // the notes "tearing" rather than ringing out.
      reverb.roomSize.value = 0.62;
      reverb.wet.value = 0.35;
      reverb.damp.value = 0.45;
      reverb.width.value = 1.0;
    } else if (reverb.isActive) {
      reverb.deactivate();
    }
  }

  @override
  void dispose() {
    if (_ready) _soloud.deinit();
    super.dispose();
  }
}
