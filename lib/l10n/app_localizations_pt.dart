// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Handpan C Egeu';

  @override
  String get navFreePlay => 'Livre';

  @override
  String get navGuided => 'Guiado';

  @override
  String get navSettings => 'Definições';

  @override
  String get freePlayCredit => 'Inspirada no youtuber e músico Malte Marten.';

  @override
  String get freePlayLabelsToggle => 'Mostrar nomes das notas';

  @override
  String get freePlayReverbToggle => 'Ressonância (reverb)';

  @override
  String get freePlayVolumeLabel => 'Volume';

  @override
  String get freePlayFooterCaption => 'C Egeu · Ding C3 + 8 campos tonais';

  @override
  String get guidedSubtitle =>
      'Escolha uma melodia, ouça primeiro ou comece já a tocar junto.';

  @override
  String get guidedTuneLabel => 'Melodia';

  @override
  String get guidedListenButton => 'Ouvir primeiro';

  @override
  String get guidedPracticeButton => 'Tocar junto';

  @override
  String get guidedStopButton => 'Parar';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 A tocar \"$tuneName\" para si …';
  }

  @override
  String get guidedListenDoneStatus =>
      'Já ouviu? Toque em \"Tocar junto\" e experimente você mesmo!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — próxima nota: $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 Tocou a melodia até ao fim! Tente novamente ou escolha outra.';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'Nota $order · $note';
  }

  @override
  String get tuneRippleName => 'Arpejo de Ondas';

  @override
  String get tuneEveningName => 'Canção da Noite';

  @override
  String get tuneSeedName => 'Semente de Improviso (prática em loop)';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsThemeSection => 'Tema';

  @override
  String get settingsThemeSystem => 'Seguir o sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsBirdVolumeSection => 'Volume dos pássaros';

  @override
  String get settingsBgmSection => 'Música de fundo';

  @override
  String get settingsBgmTrackLabel => 'Faixa';

  @override
  String get settingsBgmNone => 'Nenhuma';

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
  String get settingsLanguageSystem => 'Idioma do sistema';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Handpan C Egeu';

  @override
  String get navFreePlay => 'Livre';

  @override
  String get navGuided => 'Guiado';

  @override
  String get navSettings => 'Configurações';

  @override
  String get freePlayCredit => 'Inspirado no youtuber e músico Malte Marten.';

  @override
  String get freePlayLabelsToggle => 'Mostrar nomes das notas';

  @override
  String get freePlayReverbToggle => 'Ressonância (reverb)';

  @override
  String get freePlayVolumeLabel => 'Volume';

  @override
  String get freePlayFooterCaption => 'C Egeu · Ding C3 + 8 campos tonais';

  @override
  String get guidedSubtitle =>
      'Escolha uma melodia, ouça primeiro ou já comece a tocar junto.';

  @override
  String get guidedTuneLabel => 'Melodia';

  @override
  String get guidedListenButton => 'Ouvir primeiro';

  @override
  String get guidedPracticeButton => 'Tocar junto';

  @override
  String get guidedStopButton => 'Parar';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 Tocando \"$tuneName\" para você …';
  }

  @override
  String get guidedListenDoneStatus =>
      'Já ouviu? Toque em \"Tocar junto\" e experimente você mesmo!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — próxima nota: $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 Você tocou a melodia inteira! Tente de novo ou escolha outra.';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'Nota $order · $note';
  }

  @override
  String get tuneRippleName => 'Arpejo de Ondas';

  @override
  String get tuneEveningName => 'Canção da Noite';

  @override
  String get tuneSeedName => 'Semente de Improviso (prática em loop)';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsThemeSection => 'Tema';

  @override
  String get settingsThemeSystem => 'Seguir o sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsBirdVolumeSection => 'Volume dos pássaros';

  @override
  String get settingsBgmSection => 'Música de fundo';

  @override
  String get settingsBgmTrackLabel => 'Faixa';

  @override
  String get settingsBgmNone => 'Nenhuma';

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
  String get settingsLanguageSystem => 'Idioma do sistema';
}
