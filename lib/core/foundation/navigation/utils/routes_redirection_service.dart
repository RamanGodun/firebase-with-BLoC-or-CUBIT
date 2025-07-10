import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../layers_shared/domain_shared/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../app_routes/app_routes.dart';

/// 🧭🚦 [RoutesRedirectionService] — Handles navigation redirects based on [AuthBloc] state.
/// Used by GoRouter to:
/// - 🧭 Route unauthenticated users to sign-in
/// - 🧭 Prevent authenticated users from visiting auth pages
/// - ⏳ Show splash screen while auth status is unknown

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


/*
for debugging:

    if (kDebugMode) {
        debugPrint(
          '[🔁 Redirect] $currentPath → $target (authStatus: unknown)',
        );
      }
 */