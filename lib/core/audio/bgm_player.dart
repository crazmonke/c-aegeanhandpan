import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import '../constants/bgm_catalog.dart';

/// Plays the user's chosen BGM track on an endless, cross-faded loop -
/// same technique as `BirdAmbiencePlayer`, but with a track that can be
/// switched (or turned off entirely) at any time. Tracks are decoded
/// lazily on first selection and then kept cached for instant replays.
class BgmPlayer extends ChangeNotifier {
  final SoLoud _soloud = SoLoud.instance;
  static const _fadeDuration = Duration(milliseconds: 900);

  final Map<String, AudioSource> _sources = {};
  final Map<String, Duration> _lengths = {};

  String? _trackId;
  double _volume = 0.5;
  SoundHandle? _frontHandle;
  Timer? _cycleTimer;
  int _playToken = 0;

  String? get trackId => _trackId;
  double get volume => _volume;

  void setVolume(double value) {
    _volume = value.clamp(0.0, 1.0).toDouble();
    final handle = _frontHandle;
    if (handle != null) {
      _soloud.setVolume(handle, _volume);
    }
  }

  /// Switches to [id] (a `BgmTrack.id`), or stops playback entirely for
  /// null ("no BGM").
  Future<void> setTrack(String? id) async {
    _playToken++;
    final token = _playToken;

    _cycleTimer?.cancel();
    final oldHandle = _frontHandle;
    _frontHandle = null;
    if (oldHandle != null) {
      _soloud.fadeVolume(oldHandle, 0, _fadeDuration);
      Timer(_fadeDuration, () => _soloud.stop(oldHandle));
    }

    _trackId = id;
    if (id == null) return;

    final track = bgmTrackById(id);
    if (track == null) return;

    var source = _sources[id];
    if (source == null) {
      source = await _soloud.loadAsset(track.assetPath);
      if (token != _playToken) return; // superseded while loading
      _sources[id] = source;
      _lengths[id] = _soloud.getLength(source);
    }
    if (token != _playToken) return;
    await _startTrack(id, source, token);
  }

  Future<void> _startTrack(String id, AudioSource source, int token) async {
    final handle = await _soloud.play(source, volume: 0);
    if (token != _playToken) {
      _soloud.stop(handle);
      return;
    }
    _frontHandle = handle;
    _soloud.fadeVolume(handle, _volume, _fadeDuration);
    _scheduleNextCrossfade(id, token);
  }

  void _scheduleNextCrossfade(String id, int token) {
    final length = _lengths[id] ?? Duration.zero;
    final wait = length - _fadeDuration;
    _cycleTimer = Timer(wait > Duration.zero ? wait : length, () => _crossfade(id, token));
  }

  Future<void> _crossfade(String id, int token) async {
    if (token != _playToken) return;
    final source = _sources[id];
    if (source == null) return;

    final oldHandle = _frontHandle;
    final newHandle = await _soloud.play(source, volume: 0);
    if (token != _playToken) {
      _soloud.stop(newHandle);
      return;
    }
    _soloud.fadeVolume(newHandle, _volume, _fadeDuration);
    _frontHandle = newHandle;

    if (oldHandle != null) {
      _soloud.fadeVolume(oldHandle, 0, _fadeDuration);
      Timer(_fadeDuration, () => _soloud.stop(oldHandle));
    }

    _scheduleNextCrossfade(id, token);
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    final handle = _frontHandle;
    if (handle != null) _soloud.stop(handle);
    super.dispose();
  }
}
