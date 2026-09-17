// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Хендпан C Aegean';

  @override
  String get navFreePlay => 'Свободная игра';

  @override
  String get navGuided => 'С подсказками';

  @override
  String get navSettings => 'Настройки';

  @override
  String get freePlayCredit =>
      'Приложение создано под впечатлением от ютубера и музыканта Malte Marten.';

  @override
  String get freePlayLabelsToggle => 'Показывать названия нот';

  @override
  String get freePlayReverbToggle => 'Резонанс (реверберация)';

  @override
  String get freePlayVolumeLabel => 'Громкость';

  @override
  String get freePlayFooterCaption => 'C Aegean · Ding C3 + 8 тональных полей';

  @override
  String get guidedSubtitle =>
      'Выберите мелодию, сначала прослушайте её или сразу начните играть по подсказкам.';

  @override
  String get guidedTuneLabel => 'Мелодия';

  @override
  String get guidedListenButton => 'Сначала послушать';

  @override
  String get guidedPracticeButton => 'Играть по подсказкам';

  @override
  String get guidedStopButton => 'Остановить';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 Играем для вас «$tuneName» …';
  }

  @override
  String get guidedListenDoneStatus =>
      'Прослушали? Нажмите «Играть по подсказкам» и попробуйте сами!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — следующая нота: $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 Вы доиграли мелодию до конца! Попробуйте ещё раз или выберите другую.';

  @override
  String guidedNoteDing(String note) {
    return 'Динг · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'Нота $order · $note';
  }

  @override
  String get tuneRippleName => 'Арпеджио ряби';

  @override
  String get tuneEveningName => 'Вечерняя песня';

  @override
  String get tuneSeedName => 'Зерно импровизации (для повтора)';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsThemeSection => 'Тема';

  @override
  String get settingsThemeSystem => 'Как в системе';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeDark => 'Тёмная';

  @override
  String get settingsBirdVolumeSection => 'Громкость птиц';

  @override
  String get settingsLanguageSection => 'Язык';

  @override
  String get settingsLanguageSystem => 'Язык системы';
}
