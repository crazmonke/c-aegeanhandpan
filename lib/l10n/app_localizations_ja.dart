// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Cエーゲ・ハンドパン';

  @override
  String get navFreePlay => '自由演奏';

  @override
  String get navGuided => 'ガイド演奏';

  @override
  String get navSettings => '設定';

  @override
  String get freePlayCredit =>
      'YouTuberであり音楽家でもあるMalte Martenさんからインスピレーションを受けて作られたアプリです。';

  @override
  String get freePlayLabelsToggle => '音名を表示';

  @override
  String get freePlayReverbToggle => '共鳴(リバーブ)';

  @override
  String get freePlayVolumeLabel => '音量';

  @override
  String get freePlayFooterCaption => 'C エーゲ · Ding C3 + 8トーンフィールド';

  @override
  String get guidedSubtitle => '曲を選んで先に聴くか、そのまま一緒に演奏してみましょう。';

  @override
  String get guidedTuneLabel => '練習曲';

  @override
  String get guidedListenButton => '先に聴く';

  @override
  String get guidedPracticeButton => '一緒に演奏する';

  @override
  String get guidedStopButton => '停止';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧「$tuneName」をお聴かせします …';
  }

  @override
  String get guidedListenDoneStatus => '聴き終わりましたか?「一緒に演奏する」で試してみましょう!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — 次の音: $noteLabel';
  }

  @override
  String get guidedCompleteStatus => '🎉 最後まで演奏できました!もう一度挑戦するか、別の曲を選んでみましょう。';

  @override
  String guidedNoteDing(String note) {
    return 'Ding · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return '$order番目の音 · $note';
  }

  @override
  String get tuneRippleName => 'さざ波のアルペジオ';

  @override
  String get tuneEveningName => '夕べの歌';

  @override
  String get tuneSeedName => '即興のたね(反復練習)';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsThemeSection => 'テーマ';

  @override
  String get settingsThemeSystem => 'システムに合わせる';

  @override
  String get settingsThemeLight => 'ライト';

  @override
  String get settingsThemeDark => 'ダーク';

  @override
  String get settingsBirdVolumeSection => '鳥の声の音量';

  @override
  String get settingsBgmSection => 'BGM(背景音楽)';

  @override
  String get settingsBgmTrackLabel => '曲を選択';

  @override
  String get settingsBgmNone => '選択しない';

  @override
  String get bgmTrack1Name => 'BGM 1';

  @override
  String get bgmTrack2Name => 'BGM 2';

  @override
  String get bgmTrack3Name => 'BGM 3';

  @override
  String get bgmTrack4Name => 'BGM 4';

  @override
  String get settingsLanguageSection => '言語';

  @override
  String get settingsLanguageSystem => 'システムの言語';
}
