import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'QParking';

  @override
  String get login_subtitle => 'Access with your account to manage\nyour parking.';

  @override
  String get form_email_label => 'Email Address';

  @override
  String get form_password_label => 'Password';

  @override
  String get action_login => 'Login';

  @override
  String get action_register => 'Register';

  @override
  String get login_no_account => 'Don\'t have an account?';

  @override
  String get error_required_field => 'Required field';

  @override
  String get user_type_title => 'What type of user are you?';

  @override
  String get user_type_normal_title => 'Normal User';

  @override
  String get user_type_normal_desc => 'Register as a normal user if you only want to use, enter, and pay for parking regularly.';

  @override
  String get user_type_special_title => 'Special User';

  @override
  String get user_type_special_desc => 'Register as a special user if you are a supplier, taxi, or have an agreement with an affiliated parking lot.';
}
