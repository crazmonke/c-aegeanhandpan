// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'सी एजियन हैंडपैन';

  @override
  String get navFreePlay => 'स्वतंत्र वादन';

  @override
  String get navGuided => 'निर्देशित अभ्यास';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get freePlayCredit =>
      'यह ऐप यूट्यूबर और संगीतकार Malte Marten से प्रेरित होकर बनाई गई है।';

  @override
  String get freePlayLabelsToggle => 'स्वर नाम दिखाएँ';

  @override
  String get freePlayReverbToggle => 'गूंज (रिवर्ब)';

  @override
  String get freePlayVolumeLabel => 'आवाज़';

  @override
  String get freePlayFooterCaption => 'सी एजियन · डिंग C3 + 8 टोन फ़ील्ड';

  @override
  String get guidedSubtitle =>
      'एक धुन चुनें, पहले सुनें, या सीधे साथ बजाना शुरू करें।';

  @override
  String get guidedTuneLabel => 'अभ्यास धुन';

  @override
  String get guidedListenButton => 'पहले सुनें';

  @override
  String get guidedPracticeButton => 'साथ बजाएँ';

  @override
  String get guidedStopButton => 'रोकें';

  @override
  String guidedListeningStatus(String tuneName) {
    return '🎧 आपके लिए \"$tuneName\" बज रही है …';
  }

  @override
  String get guidedListenDoneStatus =>
      'सुन लिया? अब \"साथ बजाएँ\" दबाकर खुद आज़माइए!';

  @override
  String guidedProgressStatus(int current, int total, String noteLabel) {
    return '$current / $total — अगला स्वर: $noteLabel';
  }

  @override
  String get guidedCompleteStatus =>
      '🎉 पूरी धुन बज गई! फिर से आज़माएँ या दूसरी धुन चुनें।';

  @override
  String guidedNoteDing(String note) {
    return 'डिंग · $note';
  }

  @override
  String guidedNoteField(int order, String note) {
    return 'स्वर $order · $note';
  }

  @override
  String get tuneRippleName => 'लहर आर्पेजियो';

  @override
  String get tuneEveningName => 'साँझ का गीत';

  @override
  String get tuneSeedName => 'सुर-बीज (दोहराव अभ्यास)';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsThemeSection => 'थीम';

  @override
  String get settingsThemeSystem => 'सिस्टम अनुसार';

  @override
  String get settingsThemeLight => 'लाइट';

  @override
  String get settingsThemeDark => 'डार्क';

  @override
  String get settingsBirdVolumeSection => 'पक्षियों की आवाज़';

  @override
  String get settingsLanguageSection => 'भाषा';

  @override
  String get settingsLanguageSystem => 'सिस्टम भाषा';
}
