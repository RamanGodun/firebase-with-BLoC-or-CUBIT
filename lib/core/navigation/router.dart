import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/auth_bloc/auth_bloc.dart';
import '../../features/sign_in/sign_in_page.dart';
import '../../features/sign_up/signup_page.dart';
import '../../presentation/pages/change_password_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/page_not_found.dart';
import '../../presentation/pages/password_reset_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/verify_email_page.dart';
import '../di/injection.dart';
import 'route_names.dart';

/// 🧭 App Router — handles navigation & redirection logic
final GoRouter goRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,

  /// 🔁 Triggers rebuild when `AuthBloc` state changes
  refreshListenable: GoRouterRefreshBloc(appSingleton<AuthBloc>().stream),

  /// 🚦 Redirect logic based on AuthState
  redirect: (context, state) {
    final authState = appSingleton<AuthBloc>().state;

    final isAuthenticated = authState.authStatus == AuthStatus.authenticated;
    final isUnauthenticated =
        authState.authStatus == AuthStatus.unauthenticated;
    final isUnknown = authState.authStatus == AuthStatus.unknown;

    final isOnSplash = state.matchedLocation == '/${RouteNames.splash}';
    final isOnAuthPage = [
      '/${RouteNames.signin}',
      '/${RouteNames.signup}',
      '/${RouteNames.resetPassword}',
    ].contains(state.matchedLocation);

    // 🟡 Still loading: don't redirect yet
    if (isUnknown) return isOnSplash ? null : '/${RouteNames.splash}';

    // 🔴 Not logged in — redirect to SignIn
    if (isUnauthenticated) {
      return isOnAuthPage ? null : '/${RouteNames.signin}';
    }

    // ✅ Authenticated — redirect away from Auth pages
    if (isAuthenticated && (isOnSplash || isOnAuthPage)) {
      return '/${RouteNames.home}';
    }

    // ✅ Allow navigation
    return null;
  },

  /// 🗺️ Route Definitions
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
    ),
    GoRoute(
      path: '/${RouteNames.signin}',
      name: RouteNames.signin,
      builder: (_, __) => const SignInPage(),
    ),
    GoRoute(
      path: '/${RouteNames.signup}',
      name: RouteNames.signup,
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
  ],

  /// ❌ Fallback for unknown routes
  errorBuilder:
      (_, state) => PageNotFound(errorMessage: state.error.toString()),
);

/// 👀 Wrapper to listen to BLoC streams
class GoRouterRefreshBloc extends ChangeNotifier {
  GoRouterRefreshBloc(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
