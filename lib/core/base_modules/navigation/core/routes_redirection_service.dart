import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../utils_shared/auth_state/auth_cubit.dart';
import '../app_routes/app_routes.dart';

/// 🧭🚦 [RoutesRedirectionService] — Centralized redirect logic based on [AuthState].
/// ✅ Declaratively maps current router state + authState to needed redirect route.
///   - 🚪 `/signin` if unauthenticated
///   - 🧪 `/verifyEmail` if email is not verified
///   - 🧯 `/firebaseError` if an auth error occurs
///   - ⏳ `/splash` while loading
///   - ✅ `/home` if fully authenticated and verified
//
final class RoutesRedirectionService {
  ///-------------------------------
  RoutesRedirectionService._();
  //

  /// 🗝️ Publicly accessible routes (no authentication required)
  static const Set<String> _publicRoutes = {
    RoutesPaths.signIn,
    RoutesPaths.signUp,
    RoutesPaths.resetPassword,
  };

  /// 🔁 Maps current router state + auth state to a redirect route (if needed)
  static String? from(
    BuildContext context,
    GoRouterState goRouterState,
    AuthState authState,
  ) {
    // -----------------------
    /// 🔍 Auth status flags
    final status = authState.authStatus;
    final user = authState.user;
    final isLoading = status == AuthStatus.unknown;
    final isUnauthenticated = status == AuthStatus.unauthenticated;
    final isAuthenticated = status == AuthStatus.authenticated;
    final isAuthError = status == AuthStatus.authError; // Додати, якщо треба

    // Email verification logic
    final isEmailVerified = user?.emailVerified ?? false;

    // Current path
    final currentPath = goRouterState.matchedLocation;
    final isOnPublicPages = _publicRoutes.contains(currentPath);
    final isOnVerifyPage = currentPath == RoutesPaths.verifyEmail;
    final isOnSplashPage = currentPath == RoutesPaths.splash;

    // ⏳ Redirect to splash while loading
    if (isLoading) return isOnSplashPage ? null : RoutesPaths.splash;

    // 💥 Redirect to error page if auth error (опційно, якщо таке треба)
    if (isAuthError) return RoutesPaths.signIn;

    // 🚪 Redirect to SignIn page if unauthenticated and not on public page
    if (isUnauthenticated) return isOnPublicPages ? null : RoutesPaths.signIn;

    // 🧪 Redirect to /verifyEmail if not verified
    if (isAuthenticated && !isEmailVerified) {
      return isOnVerifyPage ? null : RoutesPaths.verifyEmail;
    }

    // ✅ Redirect to /home if already authenticated and on splash/public/verify
    if (isAuthenticated &&
        isEmailVerified &&
        (isOnPublicPages || isOnSplashPage || isOnVerifyPage)) {
      return RoutesPaths.home;
    }

    // ➖ No redirect
    return null;
  }
}

/*










/// 🧭🚦 [RoutesRedirectionService] — Centralized redirect logic based on [AuthState].
/// ✅ Declaratively maps current router state + authState to needed redirect route.
///   - 🚪 `/signin` if unauthenticated
///   - 🧪 `/verifyEmail` if email is not verified
///   - 🧯 `/firebaseError` if an auth error occurs
///   - ⏳ `/splash` while loading
///   - ✅ `/home` if fully authenticated and verified
//
final class RoutesRedirectionService {
  ///-------------------------------
  RoutesRedirectionService._();
  //

  /// 🗝️ Publicly accessible routes (no authentication required)
  static const Set<String> _publicRoutes = {
    RoutesPaths.signIn,
    RoutesPaths.signUp,
    RoutesPaths.resetPassword,
  };

  ///
  static String? from(
    BuildContext context,
    GoRouterState goRouterState,
    AuthState authState,
  ) {
    //
    /// 🔍 Auth status flags
    final authStatus = authState.authStatus;
    final isAuthenticated = authStatus == AuthStatus.authenticated;
    final isUnauthenticated = authStatus == AuthStatus.unauthenticated;
    final isUnknown = authStatus == AuthStatus.unknown;

    // 🔄 CurrentPath
    final currentPath = goRouterState.matchedLocation;

    // 📍 Route flags
    final isOnPublicPages = _publicRoutes.contains(currentPath);
    final isOnSplashPage = currentPath == RoutesPaths.splash;

    /// ⏳ Still determining auth state → redirect to Splash
    if (isUnknown) {
      return isOnSplashPage ? null : RoutesPaths.splash;
    }

    /// ❌ Unauthenticated → force sign-in (unless already on auth page)
    if (isUnauthenticated) {
      return isOnPublicPages ? null : RoutesPaths.signIn;
    }

    /// ✅ Authenticated → prevent access to splash/auth routes
    if (isAuthenticated && (isOnSplashPage || isOnPublicPages)) {
      return RoutesPaths.home;
    }

    /// ✅ No redirect needed
    return null;

    //
  }
}









for debugging:

    if (kDebugMode) {
        debugPrint(
          '[🔁 Redirect] $currentPath → $target (authStatus: unknown)',
        );
      }
 */
