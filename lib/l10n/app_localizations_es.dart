import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_name => 'QParking';

  @override
  String get login_subtitle => 'Accede con tu cuenta para pagar\ntu estacionamiento.';

  @override
  String get form_email_label => 'Correo Electrónico';

  @override
  String get form_password_label => 'Contraseña';

  @override
  String get action_login => 'Iniciar Sesión';

  @override
  String get action_register => 'Regístrate';

  @override
  String get login_no_account => '¿No tienes cuenta?';

  @override
  String get error_required_field => 'Campo requerido';

  @override
  String get user_type_title => '¿Qué tipo de usuario eres?';

  @override
  String get user_type_normal_title => 'Usuario Normal';

  @override
  String get user_type_normal_desc => 'Regístrate como usuario normal si solo deseas usar, entrar y pagar estacionamientos de forma regular.';

  @override
  String get user_type_special_title => 'Usuario Especial';

  @override
  String get user_type_special_desc => 'Regístrate como usuario especial si eres proveedor, taxi o tienes un convenio con algún estacionamiento afiliado.';
}
