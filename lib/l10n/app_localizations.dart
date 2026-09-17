import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// The application's display name.
  ///
  /// In ko, this message translates to:
  /// **'C 에게해 핸드팬'**
  String get appTitle;

  /// No description provided for @navFreePlay.
  ///
  /// In ko, this message translates to:
  /// **'자유 연주'**
  String get navFreePlay;

  /// No description provided for @navGuided.
  ///
  /// In ko, this message translates to:
  /// **'따라 연주'**
  String get navGuided;

  /// No description provided for @navSettings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get navSettings;

  /// No description provided for @freePlayCredit.
  ///
  /// In ko, this message translates to:
  /// **'유튜버이자 음악가인 Malte Marten님의 영감을 받아 제작한 앱입니다.'**
  String get freePlayCredit;

  /// No description provided for @freePlayLabelsToggle.
  ///
  /// In ko, this message translates to:
  /// **'음이름 표시'**
  String get freePlayLabelsToggle;

  /// No description provided for @freePlayReverbToggle.
  ///
  /// In ko, this message translates to:
  /// **'공명(리버브)'**
  String get freePlayReverbToggle;

  /// No description provided for @freePlayVolumeLabel.
  ///
  /// In ko, this message translates to:
  /// **'음량'**
  String get freePlayVolumeLabel;

  /// No description provided for @freePlayFooterCaption.
  ///
  /// In ko, this message translates to:
  /// **'C 에게해 · Ding C3 + 8 톤필드'**
  String get freePlayFooterCaption;

  /// No description provided for @guidedSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'곡을 고르고 먼저 들어보거나, 바로 따라 연주해보세요.'**
  String get guidedSubtitle;

  /// No description provided for @guidedTuneLabel.
  ///
  /// In ko, this message translates to:
  /// **'연습곡'**
  String get guidedTuneLabel;

  /// No description provided for @guidedListenButton.
  ///
  /// In ko, this message translates to:
  /// **'먼저 들어보기'**
  String get guidedListenButton;

  /// No description provided for @guidedPracticeButton.
  ///
  /// In ko, this message translates to:
  /// **'따라 연주하기'**
  String get guidedPracticeButton;

  /// No description provided for @guidedStopButton.
  ///
  /// In ko, this message translates to:
  /// **'중지'**
  String get guidedStopButton;

  /// No description provided for @guidedListeningStatus.
  ///
  /// In ko, this message translates to:
  /// **'🎧 {tuneName} 들려드릴게요 …'**
  String guidedListeningStatus(String tuneName);

  /// No description provided for @guidedListenDoneStatus.
  ///
  /// In ko, this message translates to:
  /// **'다 들으셨나요? \'따라 연주하기\'로 직접 쳐보세요!'**
  String get guidedListenDoneStatus;

  /// No description provided for @guidedProgressStatus.
  ///
  /// In ko, this message translates to:
  /// **'{current} / {total} — 다음 음: {noteLabel}'**
  String guidedProgressStatus(int current, int total, String noteLabel);

  /// No description provided for @guidedCompleteStatus.
  ///
  /// In ko, this message translates to:
  /// **'🎉 끝까지 연주했어요! 다시 하거나 다른 곡을 골라보세요.'**
  String get guidedCompleteStatus;

  /// No description provided for @guidedNoteDing.
  ///
  /// In ko, this message translates to:
  /// **'Ding · {note}'**
  String guidedNoteDing(String note);

  /// No description provided for @guidedNoteField.
  ///
  /// In ko, this message translates to:
  /// **'{order}번째 음 · {note}'**
  String guidedNoteField(int order, String note);

  /// No description provided for @tuneRippleName.
  ///
  /// In ko, this message translates to:
  /// **'잔물결 아르페지오'**
  String get tuneRippleName;

  /// No description provided for @tuneEveningName.
  ///
  /// In ko, this message translates to:
  /// **'저녁 노래'**
  String get tuneEveningName;

  /// No description provided for @tuneSeedName.
  ///
  /// In ko, this message translates to:
  /// **'즉흥 씨앗 (반복 연습)'**
  String get tuneSeedName;

  /// No description provided for @settingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settingsTitle;

  /// No description provided for @settingsThemeSection.
  ///
  /// In ko, this message translates to:
  /// **'테마'**
  String get settingsThemeSection;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In ko, this message translates to:
  /// **'시스템 설정'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In ko, this message translates to:
  /// **'라이트'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In ko, this message translates to:
  /// **'다크'**
  String get settingsThemeDark;

  /// No description provided for @settingsBirdVolumeSection.
  ///
  /// In ko, this message translates to:
  /// **'새소리 음량'**
  String get settingsBirdVolumeSection;

  /// No description provided for @settingsLanguageSection.
  ///
  /// In ko, this message translates to:
  /// **'언어'**
  String get settingsLanguageSection;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In ko, this message translates to:
  /// **'시스템 언어'**
  String get settingsLanguageSystem;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'ja',
    'ko',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
