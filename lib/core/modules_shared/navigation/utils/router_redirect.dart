import 'package:flutter/foundation.dart';
import '../../../../features/auth/presentation/auth_bloc/auth_bloc.dart';
import '../routes_names.dart';

/// 🔐 [AuthRedirectMapper] — Handles navigation redirects based on [AuthBloc] state.
/// Used by GoRouter to:
/// - 🧭 Route unauthenticated users to sign-in
/// - 🧭 Prevent authenticated users from visiting auth pages
/// - ⏳ Show splash screen while auth status is unknown
//----------------------------------------------------------------

final class AuthRedirectMapper {
  AuthRedirectMapper._();

  static String? from({
    required AuthBloc authBloc,
    required String currentPath,
  }) {
    //
    final status = authBloc.state.authStatus;

    /// 🔍 Auth status flags
    final isAuthenticated = status == AuthStatus.authenticated;
    final isUnauthenticated = status == AuthStatus.unauthenticated;
    final isUnknown = status == AuthStatus.unknown;

    /// 📍 Route flags
    final isSplash = currentPath == '/${RoutesNames.splash}';
    final isOnAuthPage = [
      '/${RoutesNames.signIn}',
      '/${RoutesNames.signUp}',
      '/${RoutesNames.resetPassword}',
    ].contains(currentPath);

    /// ⏳ Still determining auth state → redirect to Splash
    if (isUnknown) {
      final target = isSplash ? null : '/${RoutesNames.splash}';
      if (kDebugMode) {
        debugPrint(
          '[🔁 Redirect] $currentPath → $target (authStatus: unknown)',
        );
      }
      return target;
    }

    /// ❌ Unauthenticated → force sign-in (unless already on auth page)
    if (isUnauthenticated) {
      final target = isOnAuthPage ? null : '/${RoutesNames.signIn}';
      if (kDebugMode) {
        debugPrint(
          '[🔁 Redirect] $currentPath → $target (authStatus: unauthenticated)',
        );
      }
      return target;
    }

    /// ✅ Authenticated → prevent access to splash/auth routes
    if (isAuthenticated && (isSplash || isOnAuthPage)) {
      const target = '/${RoutesNames.home}';
      if (kDebugMode) {
        debugPrint(
          '[🔁 Redirect] $currentPath → $target (authStatus: authenticated)',
        );
      }
      return target;
    }

    /// ✅ No redirect needed
    if (kDebugMode) {
      debugPrint('[✅ No redirect] $currentPath (authStatus: $status)');
    }
    return null;

    ///
  }
}
