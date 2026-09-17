import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

/// Loops the forest video's bird-call track independently of the video
/// itself (so it gets its own volume control), and crosses two overlapping
/// instances of the same clip into each other near the loop point instead
/// of cutting and restarting abruptly.
class BirdAmbiencePlayer extends ChangeNotifier {
  final SoLoud _soloud = SoLoud.instance;
  static const _asset = 'assets/audio/forest_birdsong.mp3';
  static const _fadeDuration = Duration(milliseconds: 900);

  AudioSource? _source;
  Duration _clipLength = Duration.zero;
  double _volume = 0.5;
  bool _active = false;
  SoundHandle? _frontHandle;
  Timer? _cycleTimer;

  double get volume => _volume;

  Future<void> init() async {
    _source = await _soloud.loadAsset(_asset);
    _clipLength = _soloud.getLength(_source!);
  }

  void setVolume(double value) {
    _volume = value.clamp(0.0, 1.0).toDouble();
    final handle = _frontHandle;
    if (handle != null) {
      _soloud.setVolume(handle, _volume);
    }
  }

  void setActive(bool active) {
    if (_active == active || _source == null) return;
    _active = active;
    if (active) {
      _playFront();
    } else {
      _stopLoop();
    }
  }

  Future<void> _playFront() async {
    final source = _source;
    if (source == null) return;
    final handle = await _soloud.play(source, volume: _volume);
    _frontHandle = handle;
    _scheduleNextCrossfade();
  }

  void _scheduleNextCrossfade() {
    _cycleTimer?.cancel();
    final wait = _clipLength - _fadeDuration;
    _cycleTimer = Timer(wait > Duration.zero ? wait : _clipLength, _crossfade);
  }

  Future<void> _crossfade() async {
    final source = _source;
    if (!_active || source == null) return;

    final oldHandle = _frontHandle;
    final newHandle = await _soloud.play(source, volume: 0);
    _soloud.fadeVolume(newHandle, _volume, _fadeDuration);
    _frontHandle = newHandle;

    if (oldHandle != null) {
      _soloud.fadeVolume(oldHandle, 0, _fadeDuration);
      Timer(_fadeDuration, () => _soloud.stop(oldHandle));
    }

    _scheduleNextCrossfade();
  }

  void _stopLoop() {
    _cycleTimer?.cancel();
    _cycleTimer = null;
    final handle = _frontHandle;
    if (handle != null) {
      _soloud.stop(handle);
    }
    _frontHandle = null;
  }

  @override
  void dispose() {
    _stopLoop();
    super.dispose();
  }
}
