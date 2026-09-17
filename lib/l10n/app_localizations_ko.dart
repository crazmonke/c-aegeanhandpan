// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'C 에게해 핸드팬';

  @override
  String get navFreePlay => '자유 연주';

  @override
  String get navGuided => '따라 연주';

  @override
  String get navSettings => '설정';

  @override
  String get freePlayCredit => '유튜버이자 음악가인 Malte Marten님의 영감을 받아 제작한 앱입니다.';

  @override
  String get freePlayLabelsToggle => '음이름 표시';

  @override
  String get freePlayReverbToggle => '공명(리버브)';

  @override
  String get freePlayVolumeLabel => '음량';

  @override
  String get freePlayFooterCaption => 'C 에게해 · Ding C3 + 8 톤필드';

  @override
  String get guidedSubtitle => '곡을 고르고 먼저 들어보거나, 바로 따라 연주해보세요.';

  @override
  String get guidedTuneLabel => '연습곡';

  @override
  String get guidedListenButton => '먼저 들어보기';

  @override
  String get guidedPracticeButton => '따라 연주하기';

  @override
  String get guidedStopButton => '중지';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 $tuneName 들려드릴게요 …';
  }

  @override
  String get guidedListenDoneStatus => '다 들으셨나요? \'따라 연주하기\'로 직접 쳐보세요!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — 다음 음: $noteLabel';
  }

  @override
  String get guidedCompleteStatus => '🎉 끝까지 연주했어요! 다시 하거나 다른 곡을 골라보세요.';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return '$order번째 음 · $note';
  }

  @override
  String get tuneRippleName => '잔물결 아르페지오';

  @override
  String get tuneEveningName => '저녁 노래';

  @override
  String get tuneSeedName => '즉흥 씨앗 (반복 연습)';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsThemeSection => '테마';

  @override
  String get settingsThemeSystem => '시스템 설정';

  @override
  String get settingsThemeLight => '라이트';

  @override
  String get settingsThemeDark => '다크';

  @override
  String get settingsBirdVolumeSection => '새소리 음량';

  @override
  String get settingsLanguageSection => '언어';

  @override
  String get settingsLanguageSystem => '시스템 언어';
}
