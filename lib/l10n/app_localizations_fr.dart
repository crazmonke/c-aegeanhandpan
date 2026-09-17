// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Handpan C Égéen';

  @override
  String get navFreePlay => 'Jeu libre';

  @override
  String get navGuided => 'Guidé';

  @override
  String get navSettings => 'Réglages';

  @override
  String get freePlayCredit =>
      'Application inspirée par le YouTubeur et musicien Malte Marten.';

  @override
  String get freePlayLabelsToggle => 'Afficher les noms des notes';

  @override
  String get freePlayReverbToggle => 'Résonance (réverbération)';

  @override
  String get freePlayVolumeLabel => 'Volume';

  @override
  String get freePlayFooterCaption => 'C Égéen · Ding C3 + 8 zones tonales';

  @override
  String get guidedSubtitle =>
      'Choisissez un morceau, écoutez-le d\'abord ou jouez-le tout de suite.';

  @override
  String get guidedTuneLabel => 'Morceau';

  @override
  String get guidedListenButton => 'Écouter d\'abord';

  @override
  String get guidedPracticeButton => 'Jouer en même temps';

  @override
  String get guidedStopButton => 'Arrêter';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 Lecture de « $tuneName » pour vous …';
  }

  @override
  String get guidedListenDoneStatus =>
      'Vous avez écouté ? Appuyez sur « Jouer en même temps » et essayez !';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — note suivante : $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 Vous avez joué le morceau en entier ! Recommencez ou choisissez-en un autre.';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'Note $order · $note';
  }

  @override
  String get tuneRippleName => 'Arpège des vaguelettes';

  @override
  String get tuneEveningName => 'Chant du soir';

  @override
  String get tuneSeedName => 'Graine d\'improvisation (boucle d\'entraînement)';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsThemeSection => 'Thème';

  @override
  String get settingsThemeSystem => 'Suivre le système';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsBirdVolumeSection => 'Volume des oiseaux';

  @override
  String get settingsLanguageSection => 'Langue';

  @override
  String get settingsLanguageSystem => 'Langue du système';
}
