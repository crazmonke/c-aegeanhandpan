import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_settings_controller.dart';
import '../../core/audio/bgm_player.dart';
import '../../core/audio/bird_ambience_player.dart';
import '../../core/constants/bgm_catalog.dart';
import '../../l10n/app_localizations.dart';

class _LanguageOption {
  const _LanguageOption(this.locale, this.nativeName);

  final Locale locale;
  final String nativeName;
}

// Mirrors the language set from the sibling Babgap app (11 shipped ARB
// locales: ko template + these 10 pickable options; app_pt.arb also ships
// so a bare-"pt" system locale still resolves without a country code).
const _languageOptions = [
  _LanguageOption(Locale('ko'), '한국어'),
  _LanguageOption(Locale('en'), 'English'),
  _LanguageOption(Locale('ja'), '日本語'),
  _LanguageOption(Locale('zh'), '中文'),
  _LanguageOption(Locale('es'), 'Español'),
  _LanguageOption(Locale('hi'), 'हिन्दी'),
  _LanguageOption(Locale('pt', 'BR'), 'Português (Brasil)'),
  _LanguageOption(Locale('ru'), 'Русский'),
  _LanguageOption(Locale('de'), 'Deutsch'),
  _LanguageOption(Locale('fr'), 'Français'),
];

/// The one screen without the ambient video background, so it uses the
/// normal theme-driven colors (unlike Free Play / Guided Practice).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<AppSettingsController>();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.settingsTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          _SectionLabel(l10n.settingsThemeSection),
          Card(
            child: RadioGroup<ThemeMode>(
              groupValue: settings.themeMode,
              onChanged: (mode) => settings.setThemeMode(mode!),
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(title: Text(l10n.settingsThemeSystem), value: ThemeMode.system),
                  RadioListTile<ThemeMode>(title: Text(l10n.settingsThemeLight), value: ThemeMode.light),
                  RadioListTile<ThemeMode>(title: Text(l10n.settingsThemeDark), value: ThemeMode.dark),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionLabel(l10n.settingsBirdVolumeSection),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.music_note_outlined),
                  Expanded(
                    child: Slider(
                      value: settings.birdVolume * 100,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: '${(settings.birdVolume * 100).round()}',
                      onChanged: (value) {
                        final volume = value / 100;
                        settings.setBirdVolume(volume);
                        context.read<BirdAmbiencePlayer>().setVolume(volume);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 34,
                    child: Text(
                      '${(settings.birdVolume * 100).round()}',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionLabel(l10n.settingsBgmSection),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String?>(
                    initialValue: settings.bgmTrackId,
                    decoration: InputDecoration(
                      labelText: l10n.settingsBgmTrackLabel,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem<String?>(value: null, child: Text(l10n.settingsBgmNone)),
                      for (final track in bgmCatalog)
                        DropdownMenuItem<String?>(value: track.id, child: Text(track.nameOf(l10n))),
                    ],
                    onChanged: (id) {
                      settings.setBgmTrackId(id);
                      context.read<BgmPlayer>().setTrack(id);
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.library_music_outlined),
                      Expanded(
                        child: Slider(
                          value: settings.bgmVolume * 100,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: '${(settings.bgmVolume * 100).round()}',
                          onChanged: settings.bgmTrackId == null
                              ? null
                              : (value) {
                                  final volume = value / 100;
                                  settings.setBgmVolume(volume);
                                  context.read<BgmPlayer>().setVolume(volume);
                                },
                        ),
                      ),
                      SizedBox(
                        width: 34,
                        child: Text(
                          '${(settings.bgmVolume * 100).round()}',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionLabel(l10n.settingsLanguageSection),
          Card(
            child: RadioGroup<Locale?>(
              groupValue: settings.locale,
              onChanged: settings.setLocale,
              child: Column(
                children: [
                  RadioListTile<Locale?>(title: Text(l10n.settingsLanguageSystem), value: null),
                  for (final option in _languageOptions)
                    RadioListTile<Locale?>(title: Text(option.nativeName), value: option.locale),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
