import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/app_settings_controller.dart';
import 'core/audio/bird_ambience_player.dart';
import 'core/audio/handpan_audio_engine.dart';
import 'core/storage/app_settings_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsStore = await AppSettingsStore.create();
  final settingsController = AppSettingsController(settingsStore);

  final audioEngine = HandpanAudioEngine();
  await audioEngine.init();

  final birdAmbiencePlayer = BirdAmbiencePlayer();
  await birdAmbiencePlayer.init();
  birdAmbiencePlayer.setVolume(settingsController.birdVolume);

  runApp(
    HandpanApp(
      settingsController: settingsController,
      audioEngine: audioEngine,
      birdAmbiencePlayer: birdAmbiencePlayer,
    ),
  );
}
