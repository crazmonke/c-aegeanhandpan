import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the user's language and light/dark theme overrides. Both
/// default to following the system (locale auto-detected, theme via
/// `ThemeMode.system`) until the user picks something in Settings.
class AppSettingsStore {
  AppSettingsStore._(this._prefs);

  static const _languageCodeKey = 'languageCode';
  static const _themeModeKey = 'themeMode';
  static const _birdVolumeKey = 'birdVolume';

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
  /// volume), stored as 0.0-1.0. Defaults to 0.5 (50%).
  double get birdVolume => _prefs.getDouble(_birdVolumeKey) ?? 0.5;

  Future<void> setBirdVolume(double value) {
    return _prefs.setDouble(_birdVolumeKey, value);
  }
}
