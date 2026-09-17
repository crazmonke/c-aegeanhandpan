// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'C Aegean Handpan';

  @override
  String get navFreePlay => 'Free Play';

  @override
  String get navGuided => 'Guided';

  @override
  String get navSettings => 'Settings';

  @override
  String get freePlayCredit =>
      'Inspired by YouTuber and musician Malte Marten.';

  @override
  String get freePlayLabelsToggle => 'Show note names';

  @override
  String get freePlayReverbToggle => 'Resonance (reverb)';

  @override
  String get freePlayVolumeLabel => 'Volume';

  @override
  String get freePlayFooterCaption => 'C Aegean · Ding C3 + 8 tone fields';

  @override
  String get guidedSubtitle =>
      'Pick a tune, listen first, or jump straight into playing along.';

  @override
  String get guidedTuneLabel => 'Tune';

  @override
  String get guidedListenButton => 'Listen first';

  @override
  String get guidedPracticeButton => 'Play along';

  @override
  String get guidedStopButton => 'Stop';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 Playing \"$tuneName\" for you …';
  }

  @override
  String get guidedListenDoneStatus =>
      'Ready? Tap \"Play along\" and try it yourself!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — next note: $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 You played the whole tune! Try again or pick another one.';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'Note $order · $note';
  }

  @override
  String get tuneRippleName => 'Ripple Arpeggio';

  @override
  String get tuneEveningName => 'Evening Song';

  @override
  String get tuneSeedName => 'Improv Seed (loop practice)';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeSection => 'Theme';

  @override
  String get settingsThemeSystem => 'Follow system';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsBirdVolumeSection => 'Bird sound volume';

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsLanguageSystem => 'System language';
}
