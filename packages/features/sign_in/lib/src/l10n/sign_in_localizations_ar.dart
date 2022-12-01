import 'sign_in_localizations.dart';

/// The translations for Arabic (`ar`).
class SignInLocalizationsAr extends SignInLocalizations {
  SignInLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'تسجيل الدخول';

  @override
  String get usernameTextFieldLabel => 'اسم المستخدم';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور';

  @override
  String get forgotMyPasswordButtonLabel => 'نسيت كملة المرور';

  @override
  String get signInButtonLabel => 'تسجيل الدخول';

  @override
  String get signUpOpeningText => 'لا يوجد لديك حساب؟';

  @override
  String get signUpButtonLabel => 'إنشاء حساب';

  @override
  String get invalidCredentialsErrorMessage => 'خطأ في البريد الألكتروني او كلمة المرور';
}
