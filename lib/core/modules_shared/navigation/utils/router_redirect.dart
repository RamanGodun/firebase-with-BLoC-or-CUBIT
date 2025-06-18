import '../../../layers_shared/domain_shared/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../app_routes/app_routes.dart';

/// 🧭🚦 [RoutesRedirectionService] — Handles navigation redirects based on [AuthBloc] state.
/// Used by GoRouter to:
/// - 🧭 Route unauthenticated users to sign-in
/// - 🧭 Prevent authenticated users from visiting auth pages
/// - ⏳ Show splash screen while auth status is unknown

final class RoutesRedirectionService {
  //----------------------------------------------
  RoutesRedirectionService._();
  //

  static String? from({
    required AuthStatus authStatus,
    required String currentPath,
    bool isEmailVerified = true,
    bool isError = false,
    bool isLoading = false,
  }) {
    //
    /// 🔍 Auth status flags
    final isAuthenticated = authStatus == AuthStatus.authenticated;
    final isUnauthenticated = authStatus == AuthStatus.unauthenticated;
    final isUnknown = authStatus == AuthStatus.unknown;

    /// 📍 Route flags
    final isSplash = currentPath == RoutesPaths.splash;
    final isOnAuthPage = [
      RoutesPaths.signIn,
      RoutesPaths.signUp,
      RoutesPaths.resetPassword,
    ].contains(currentPath);

    /// ⏳ Still determining auth state → redirect to Splash
    if (isUnknown) {
      return isSplash ? null : RoutesPaths.splash;
    }

    /// ❌ Unauthenticated → force sign-in (unless already on auth page)
    if (isUnauthenticated) {
      return isOnAuthPage ? null : RoutesPaths.signIn;
    }

    /// ✅ Authenticated → prevent access to splash/auth routes
    if (isAuthenticated && (isSplash || isOnAuthPage)) {
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