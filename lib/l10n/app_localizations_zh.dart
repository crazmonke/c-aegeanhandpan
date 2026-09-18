// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'C 爱琴手碟';

  @override
  String get navFreePlay => '自由演奏';

  @override
  String get navGuided => '跟弹引导';

  @override
  String get navSettings => '设置';

  @override
  String get freePlayCredit => '灵感来自 YouTuber 兼音乐人 Malte Marten。';

  @override
  String get freePlayLabelsToggle => '显示音名';

  @override
  String get freePlayReverbToggle => '共鸣(混响)';

  @override
  String get freePlayVolumeLabel => '音量';

  @override
  String get freePlayFooterCaption => 'C 爱琴 · Ding C3 + 8 个音区';

  @override
  String get guidedSubtitle => '选一首曲子,先听一遍,或者直接跟着弹奏。';

  @override
  String get guidedTuneLabel => '练习曲';

  @override
  String get guidedListenButton => '先听一遍';

  @override
  String get guidedPracticeButton => '跟着弹奏';

  @override
  String get guidedStopButton => '停止';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 正在为你播放《$tuneName》…';
  }

  @override
  String get guidedListenDoneStatus => '听完了吗?点击「跟着弹奏」自己试试看!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — 下一个音: $noteLabel';
  }

  @override
  String get guidedCompleteStatus => '🎉 弹完整首曲子啦!再来一遍,或者换一首试试。';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return '第 $order 音 · $note';
  }

  @override
  String get tuneRippleName => '涟漪琶音';

  @override
  String get tuneEveningName => '夜曲';

  @override
  String get tuneSeedName => '即兴种子(循环练习)';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsThemeSection => '主题';

  @override
  String get settingsThemeSystem => '跟随系统';

  @override
  String get settingsThemeLight => '浅色';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsBirdVolumeSection => '鸟鸣音量';

  @override
  String get settingsBgmSection => '背景音乐';

  @override
  String get settingsBgmTrackLabel => '选择曲目';

  @override
  String get settingsBgmNone => '不使用';

  @override
  String get bgmTrack1Name => 'BGM 1';

  @override
  String get bgmTrack2Name => 'BGM 2';

  @override
  String get bgmTrack3Name => 'BGM 3';

  @override
  String get bgmTrack4Name => 'BGM 4';

  @override
  String get settingsLanguageSection => '语言';

  @override
  String get settingsLanguageSystem => '系统语言';
}
