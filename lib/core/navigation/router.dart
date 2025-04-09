import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../features/auth_bloc/auth_bloc.dart';
import '../../features/profile/profile_page.dart';
import '../../features/sign_in/sign_in_page.dart';
import '../../features/sign_up/signup_page.dart';
import '../../presentation/pages/change_password_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/page_not_found.dart';
import '../../presentation/pages/password_reset_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/verify_email_page.dart';
import 'router_refresh_bloc.dart' show GoRouterRefreshBloc;

part 'route_names.dart';

/// 🧭 [goRouter] — App-level navigation handler with auth-aware redirection.
final GoRouter goRouter = GoRouter(
  initialLocation: '/${RouteNames.splash}',
  debugLogDiagnostics: true,

  /// 🔁 Rebuilds routes when `AuthBloc` emits new state
  refreshListenable: GoRouterRefreshBloc(appSingleton<AuthBloc>().stream),

  /// 🚦 Redirects based on current auth state
  redirect: (context, state) {
    final authState = appSingleton<AuthBloc>().state;

    final isAuthenticated = authState.authStatus == AuthStatus.authenticated;
    final isUnauthenticated =
        authState.authStatus == AuthStatus.unauthenticated;
    final isUnknown = authState.authStatus == AuthStatus.unknown;

    final currentPath = state.matchedLocation;

    final isOnSplash = currentPath == '/${RouteNames.splash}';
    final isOnAuthPage = [
      '/${RouteNames.signIn}',
      '/${RouteNames.signUp}',
      '/${RouteNames.resetPassword}',
    ].contains(currentPath);

    if (isUnknown) return isOnSplash ? null : '/${RouteNames.splash}';
    if (isUnauthenticated) return isOnAuthPage ? null : '/${RouteNames.signIn}';
    if (isAuthenticated && (isOnSplash || isOnAuthPage)) {
      return '/${RouteNames.home}';
    }

    return null;
  },

  /// 🗺️ Route definitions
  routes: [
    GoRoute(
      path: '/${RouteNames.splash}',
      name: RouteNames.splash,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: '/${RouteNames.home}',
      name: RouteNames.home,
      builder: (_, __) => const HomePage(),
      routes: [
        GoRoute(
          path: RouteNames.profile,
          name: RouteNames.profile,
          builder: (_, __) => const ProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/${RouteNames.signIn}',
      name: RouteNames.signIn,
      builder: (_, __) => const SignInPage(),
    ),
    GoRoute(
      path: '/${RouteNames.signUp}',
      name: RouteNames.signUp,
      builder: (_, __) => const SignUpPage(),
    ),
    GoRoute(
      path: '/${RouteNames.resetPassword}',
      name: RouteNames.resetPassword,
      builder: (_, __) => const ResetPasswordPage(),
    ),
    GoRoute(
      path: '/${RouteNames.verifyEmail}',
      name: RouteNames.verifyEmail,
      builder: (_, __) => const VerifyEmailPage(),
    ),
    GoRoute(
      path: '/${RouteNames.changePassword}',
      name: RouteNames.changePassword,
      builder: (_, __) => const ChangePasswordPage(),
    ),

    /// 🧪 Dev/Test fallback page
    GoRoute(
      path: '/${RouteNames.pageNotFound}',
      name: RouteNames.pageNotFound,
      builder: (_, __) => const PageNotFound(errorMessage: 'Test'),
    ),
  ],

  /// ❌ Fallback for unmatched routes
  errorBuilder:
      (_, state) => PageNotFound(
        errorMessage: state.error?.toString() ?? 'Unknown error',
      ),
);
