// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'C Aegean Handpan';

  @override
  String get navFreePlay => 'Frei spielen';

  @override
  String get navGuided => 'Angeleitet';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get freePlayCredit =>
      'Diese App wurde von YouTuber und Musiker Malte Marten inspiriert.';

  @override
  String get freePlayLabelsToggle => 'Notennamen anzeigen';

  @override
  String get freePlayReverbToggle => 'Resonanz (Hall)';

  @override
  String get freePlayVolumeLabel => 'Lautstärke';

  @override
  String get freePlayFooterCaption => 'C Aegean · Ding C3 + 8 Klangfelder';

  @override
  String get guidedSubtitle =>
      'Wähle ein Stück, höre es dir zuerst an oder spiele direkt mit.';

  @override
  String get guidedTuneLabel => 'Übungsstück';

  @override
  String get guidedListenButton => 'Zuerst anhören';

  @override
  String get guidedPracticeButton => 'Mitspielen';

  @override
  String get guidedStopButton => 'Stopp';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 Spiele gerade \"$tuneName\" für dich …';
  }

  @override
  String get guidedListenDoneStatus =>
      'Fertig gehört? Tippe auf \"Mitspielen\" und probiere es selbst!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — nächster Ton: $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 Du hast das ganze Stück gespielt! Versuch es noch einmal oder wähle ein anderes.';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'Ton $order · $note';
  }

  @override
  String get tuneRippleName => 'Wellen-Arpeggio';

  @override
  String get tuneEveningName => 'Abendlied';

  @override
  String get tuneSeedName => 'Improvisationskeim (Übungsschleife)';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsThemeSection => 'Design';

  @override
  String get settingsThemeSystem => 'Systemeinstellung';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsBirdVolumeSection => 'Vogelgezwitscher-Lautstärke';

  @override
  String get settingsBgmSection => 'Hintergrundmusik';

  @override
  String get settingsBgmTrackLabel => 'Titel';

  @override
  String get settingsBgmNone => 'Keine';

  @override
  String get bgmTrack1Name => 'BGM 1';

  @override
  String get bgmTrack2Name => 'BGM 2';

  @override
  String get bgmTrack3Name => 'BGM 3';

  @override
  String get bgmTrack4Name => 'BGM 4';

  @override
  String get settingsLanguageSection => 'Sprache';

  @override
  String get settingsLanguageSystem => 'Systemsprache';
}
