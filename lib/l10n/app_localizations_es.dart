// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Handpan C Egeo';

  @override
  String get navFreePlay => 'Libre';

  @override
  String get navGuided => 'Guiado';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get freePlayCredit =>
      'Inspirada en el youtuber y músico Malte Marten.';

  @override
  String get freePlayLabelsToggle => 'Mostrar nombres de notas';

  @override
  String get freePlayReverbToggle => 'Resonancia (reverberación)';

  @override
  String get freePlayVolumeLabel => 'Volumen';

  @override
  String get freePlayFooterCaption => 'C Egeo · Ding C3 + 8 campos tonales';

  @override
  String get guidedSubtitle =>
      'Elige una melodía, escúchala primero o empieza a tocarla directamente.';

  @override
  String get guidedTuneLabel => 'Melodía';

  @override
  String get guidedListenButton => 'Escuchar primero';

  @override
  String get guidedPracticeButton => 'Tocar junto con la guía';

  @override
  String get guidedStopButton => 'Detener';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 Reproduciendo \"$tuneName\" …';
  }

  @override
  String get guidedListenDoneStatus =>
      '¿Ya la escuchaste? ¡Pulsa \"Tocar junto con la guía\" y pruébalo tú mismo!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — siguiente nota: $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 ¡Completaste toda la melodía! Vuelve a intentarlo o elige otra.';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'Nota $order · $note';
  }

  @override
  String get tuneRippleName => 'Arpegio de olas';

  @override
  String get tuneEveningName => 'Canción del atardecer';

  @override
  String get tuneSeedName => 'Semilla de improvisación (práctica en bucle)';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsThemeSection => 'Tema';

  @override
  String get settingsThemeSystem => 'Igual que el sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsBirdVolumeSection => 'Volumen de los pájaros';

  @override
  String get settingsBgmSection => 'Música de fondo';

  @override
  String get settingsBgmTrackLabel => 'Pista';

  @override
  String get settingsBgmNone => 'Ninguna';

  @override
  String get bgmTrack1Name => 'BGM 1';

  @override
  String get bgmTrack2Name => 'BGM 2';

  @override
  String get bgmTrack3Name => 'BGM 3';

  @override
  String get bgmTrack4Name => 'BGM 4';

  @override
  String get settingsLanguageSection => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Idioma del sistema';
}
