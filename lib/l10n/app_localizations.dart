import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

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
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @onboarding_main.
  ///
  /// In en, this message translates to:
  /// **'Bring your collection to life.'**
  String get onboarding_main;

  /// No description provided for @onboarding_main_sub.
  ///
  /// In en, this message translates to:
  /// **'Beyond the display, into the spotlight.'**
  String get onboarding_main_sub;

  /// No description provided for @onboarding_light_main.
  ///
  /// In en, this message translates to:
  /// **'Set the perfect mood.'**
  String get onboarding_light_main;

  /// No description provided for @onboarding_light_sub.
  ///
  /// In en, this message translates to:
  /// **'Tailor the lighting to match the soul of your figures.\nEvery shade tells a different story.'**
  String get onboarding_light_sub;

  /// No description provided for @onboarding_humi_main.
  ///
  /// In en, this message translates to:
  /// **'Timeless beauty, preserved.'**
  String get onboarding_humi_main;

  /// No description provided for @onboarding_humi_sub.
  ///
  /// In en, this message translates to:
  /// **'Keep your prized possessions in pristine condition.\nWe protect them from the elements.'**
  String get onboarding_humi_sub;

  /// No description provided for @onboarding_rotate_main.
  ///
  /// In en, this message translates to:
  /// **'Art in every angle.'**
  String get onboarding_rotate_main;

  /// No description provided for @onboarding_rotate_sub.
  ///
  /// In en, this message translates to:
  /// **'Experience dynamic 360° views.\nDiscover hidden details with smooth, precision-controlled rotation.'**
  String get onboarding_rotate_sub;

  /// No description provided for @onboarding_start_main.
  ///
  /// In en, this message translates to:
  /// **'Ready to create your own sanctuary?'**
  String get onboarding_start_main;

  /// No description provided for @onboarding_start_sub.
  ///
  /// In en, this message translates to:
  /// **'Start My Gallery.'**
  String get onboarding_start_sub;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Anytime, Anywhere, with one account.'**
  String get loginSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @empty_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get empty_email;

  /// No description provided for @invaild_email_format.
  ///
  /// In en, this message translates to:
  /// **'Invaild email format.'**
  String get invaild_email_format;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @empty_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get empty_password;

  /// No description provided for @lower_6letters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6.'**
  String get lower_6letters;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forget_password;

  /// No description provided for @not_have_account.
  ///
  /// In en, this message translates to:
  /// **'You not have an account?'**
  String get not_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
