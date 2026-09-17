import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/audio/bird_ambience_player.dart';
import '../core/audio/handpan_audio_engine.dart';
import '../features/root/root_shell.dart';
import '../l10n/app_localizations.dart';
import 'app_settings_controller.dart';
import 'theme.dart';

class HandpanApp extends StatelessWidget {
  const HandpanApp({
    super.key,
    required this.settingsController,
    required this.audioEngine,
    required this.birdAmbiencePlayer,
  });

  final AppSettingsController settingsController;
  final HandpanAudioEngine audioEngine;
  final BirdAmbiencePlayer birdAmbiencePlayer;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettingsController>.value(value: settingsController),
        ChangeNotifierProvider<HandpanAudioEngine>.value(value: audioEngine),
        ChangeNotifierProvider<BirdAmbiencePlayer>.value(value: birdAmbiencePlayer),
      ],
      child: Consumer<AppSettingsController>(
        builder: (context, settings, _) {
          return MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const RootShell(),
          );
        },
      ),
    );
  }
}
