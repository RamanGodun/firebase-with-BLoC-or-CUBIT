library;

/// 🏷️ [RoutesNames] — Centralized route name constants used across the app
/// ✅ Used in GoRouter config, navigation logic, and redirection guards

abstract final class RoutesNames {
  //-----------------------------
  RoutesNames._();
  //

  /// ⏳ Splash / Loading Page
  static const splash = 'splash';

  /// 🔐 Sign In Page
  static const signIn = 'signin';

  /// 🆕 Sign Up Page
  static const signUp = 'signup';

  /// 📧 Verify Email Page
  static const verifyEmail = 'verifyEmail';

  /// 🏠 Home Page
  static const home = 'home';

  /// 👤 Profile Page
  static const profile = 'profile';

  /// 🔁 Reset Password Page
  static const resetPassword = 'resetPassword';

  /// 🛠 Change Password Page
  static const changePassword = 'changePassword';

  /// 🔑 Re-authentication Page (e.g. before changing password)
  static const String reAuthentication = 'reAuthenticationPage';

  /// ❌ Fallback Error Page (e.g. 404)
  static const pageNotFound = 'pageNotFound';

  /// 🚫 Firebase Auth Error Page
  static const String firebaseError = 'firebaseError';

  //
}
