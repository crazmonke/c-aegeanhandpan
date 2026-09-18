import 'package:flutter/material.dart';

import '../core/storage/app_settings_store.dart';

/// Drives the language and theme overrides that feed `MaterialApp` (see
/// `HandpanApp`) and are edited from the Settings screen. A null [locale]
/// means "follow the system language".
class AppSettingsController extends ChangeNotifier {
  AppSettingsController(this._store);

  final AppSettingsStore _store;

  Locale? get locale {
    final code = _store.languageCode;
    if (code == null) return null;
    final parts = code.split('_');
    return parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
  }

  Future<void> setLocale(Locale? locale) async {
    await _store.setLanguageCode(
      locale == null
          ? null
          : [locale.languageCode, if (locale.countryCode != null) locale.countryCode!].join('_'),
    );
    notifyListeners();
  }

  ThemeMode get themeMode => _store.themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    await _store.setThemeMode(mode);
    notifyListeners();
  }

  double get birdVolume => _store.birdVolume;

  Future<void> setBirdVolume(double value) async {
    await _store.setBirdVolume(value);
    notifyListeners();
  }

  bool get reverbEnabled => _store.reverbEnabled;

  Future<void> setReverbEnabled(bool value) async {
    await _store.setReverbEnabled(value);
    notifyListeners();
  }

  double get freePlayVolume => _store.freePlayVolume;

  Future<void> setFreePlayVolume(double value) async {
    await _store.setFreePlayVolume(value);
    notifyListeners();
  }

  double get bgmVolume => _store.bgmVolume;

  Future<void> setBgmVolume(double value) async {
    await _store.setBgmVolume(value);
    notifyListeners();
  }

  String? get bgmTrackId => _store.bgmTrackId;

  Future<void> setBgmTrackId(String? id) async {
    await _store.setBgmTrackId(id);
    notifyListeners();
  }
}
