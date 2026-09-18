import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the user's language, theme, and audio-mix overrides. Language
/// defaults to following the system, theme to `ThemeMode.system`; the
/// audio settings default to a quiet-but-present ambience: bird volume
/// 5%, reverb off, free-play (handpan) volume at 50%, no BGM track.
class AppSettingsStore {
  AppSettingsStore._(this._prefs);

  static const _languageCodeKey = 'languageCode';
  static const _themeModeKey = 'themeMode';
  static const _birdVolumeKey = 'birdVolume';
  static const _reverbEnabledKey = 'reverbEnabled';
  static const _freePlayVolumeKey = 'freePlayVolume';
  static const _bgmVolumeKey = 'bgmVolume';
  static const _bgmTrackIdKey = 'bgmTrackId';

  final SharedPreferences _prefs;

  static Future<AppSettingsStore> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AppSettingsStore._(prefs);
  }

  /// A bare language code ("en") or "language_COUNTRY" ("pt_BR"), or null
  /// to follow the system language.
  String? get languageCode => _prefs.getString(_languageCodeKey);

  Future<void> setLanguageCode(String? code) {
    if (code == null) return _prefs.remove(_languageCodeKey);
    return _prefs.setString(_languageCodeKey, code);
  }

  ThemeMode get themeMode {
    switch (_prefs.getString(_themeModeKey)) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) {
    return _prefs.setString(_themeModeKey, mode.name);
  }

  /// The ambient bird-call volume (separate from the handpan's own
  /// volume), stored as 0.0-1.0. Defaults to 0.05 (5%).
  double get birdVolume => _prefs.getDouble(_birdVolumeKey) ?? 0.05;

  Future<void> setBirdVolume(double value) {
    return _prefs.setDouble(_birdVolumeKey, value);
  }

  /// Whether the handpan's resonance (reverb) filter is on. Defaults to
  /// off.
  bool get reverbEnabled => _prefs.getBool(_reverbEnabledKey) ?? false;

  Future<void> setReverbEnabled(bool value) {
    return _prefs.setBool(_reverbEnabledKey, value);
  }

  /// The handpan's own (Free Play / Guided Practice) master volume,
  /// stored as 0.0-1.0. Defaults to 0.5 (50%).
  double get freePlayVolume => _prefs.getDouble(_freePlayVolumeKey) ?? 0.5;

  Future<void> setFreePlayVolume(double value) {
    return _prefs.setDouble(_freePlayVolumeKey, value);
  }

  /// The background-music volume, stored as 0.0-1.0. Defaults to 0.5
  /// (50%) - only audible once a track is picked below.
  double get bgmVolume => _prefs.getDouble(_bgmVolumeKey) ?? 0.5;

  Future<void> setBgmVolume(double value) {
    return _prefs.setDouble(_bgmVolumeKey, value);
  }

  /// The selected BGM track's id (see `bgmCatalog`), or null for
  /// "None" - no background music. Defaults to null.
  String? get bgmTrackId => _prefs.getString(_bgmTrackIdKey);

  Future<void> setBgmTrackId(String? id) {
    if (id == null) return _prefs.remove(_bgmTrackIdKey);
    return _prefs.setString(_bgmTrackIdKey, id);
  }
}
