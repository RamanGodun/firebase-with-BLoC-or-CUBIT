import 'package:firebase_auth/firebase_auth.dart' show User;
import '../../../app_bootstrap_and_config/app_configs/firebase/firebase_constants.dart';
import '../../base_modules/errors_handling/failures/failure_entity.dart';

/// 🧩 [AuthUserUtils] — centralized utils for accessing current user
/// 🛡️ Guarantees null-safe usage of FirebaseAuth.currentUser
/// 🧼 Use in Repositories or UseCases

abstract final class AuthUserUtils {
  //-------------------------------

  /// 👤 Returns current user or throws [FirebaseUserMissingFailure]
  static User get currentUserOrThrow {
    final user = FirebaseConstants.fbAuth.currentUser;
    if (user == null) throw FirebaseUserMissingFailure();
    return user;
  }

  /// ❓ Returns current user if present, or `null`
  static User? get currentUserOrNull => FirebaseConstants.fbAuth.currentUser;

  /// 🆔 Returns user UID or throws
  static String get uid => currentUserOrThrow.uid;

  /// 📬 Returns user email or throws
  static String get email => currentUserOrThrow.email ?? 'unknown';

  /// 🔄 Reload current user (throw Exception if user == null)
  static Future<void> reloadCurrentUser({Duration? delay}) async {
    final user = currentUserOrThrow;
    if (delay != null) {
      await Future.delayed(delay);
    }
    await user.reload();
  }

  // (here can be add methods, tokens, refresh ...)
}
