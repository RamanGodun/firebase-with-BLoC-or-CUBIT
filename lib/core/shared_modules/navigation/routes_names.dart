part of '_imports_for_router.dart';

/// 🏷️ [RoutesNames] — Centralized route name constants used across the app
/// ✅ Used in GoRouter config, navigation logic, and redirection guards
//---------------------------------------------------------------

final class RoutesNames {
  const RoutesNames._();

  /// 🏠 Home Page
  static const home = 'home';

  /// 👤 Profile Page
  static const profile = 'profile';

  /// 🔐 Sign In Page
  static const signIn = 'signin';

  /// 🆕 Sign Up Page
  static const signUp = 'signup';

  /// 🔁 Reset Password Page
  static const resetPassword = 'resetPassword';

  /// 📧 Verify Email Page
  static const verifyEmail = 'verifyEmail';

  /// 🛠 Change Password Page
  static const changePassword = 'changePassword';

  /// ⏳ Splash / Loading Page
  static const splash = 'splash';

  /// ❌ Fallback Error Page (e.g. 404)
  static const pageNotFound = 'firebaseError';

  ///
}
