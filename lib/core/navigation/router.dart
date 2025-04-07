import 'package:go_router/go_router.dart';
import '../../features/auth/auth_bloc/auth_bloc.dart';
import '../../features/sign_in/signin_page.dart';
import '../../features/sign_up/signup_page.dart';
import '../../presentation/pages/change_password_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/page_not_found.dart';
import '../../presentation/pages/password_reset_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/verify_email_page.dart';
import '../di/injection.dart';
import 'route_names.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/splash',

  /// 🔁 Handles redirection based on auth status and email verification
  redirect: (context, state) {
    final authState = appSingleton<AuthBloc>().state;

    final isAuthUnknown = authState.authStatus == AuthStatus.unknown;
    final isAuthenticated = authState.authStatus == AuthStatus.authenticated;
    final isVerified = authState.user?.emailVerified ?? false;

    final isOnAuthScreen = [
      '/${RouteNames.signin}',
      '/${RouteNames.signup}',
      '/${RouteNames.resetPassword}',
    ].contains(state.matchedLocation);

    if (isAuthUnknown) return '/${RouteNames.splash}';
    if (!isAuthenticated) {
      return isOnAuthScreen ? null : '/${RouteNames.signin}';
    }
    if (!isVerified) return '/${RouteNames.verifyEmail}';

    final isOnSplash = state.matchedLocation == '/${RouteNames.splash}';
    final isOnVerify = state.matchedLocation == '/${RouteNames.verifyEmail}';

    return (isOnSplash || isOnVerify || isOnAuthScreen)
        ? '/${RouteNames.home}'
        : null;
  },

  /// 📌 Route Definitions
  routes: [
    GoRoute(
      path: '/${RouteNames.splash}',
      name: RouteNames.splash,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: '/${RouteNames.signin}',
      name: RouteNames.signin,
      builder: (_, __) => const SigninPage(),
    ),
    GoRoute(
      path: '/${RouteNames.signup}',
      name: RouteNames.signup,
      builder: (_, __) => const SignupPage(),
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
      path: '/${RouteNames.home}',
      name: RouteNames.home,
      builder: (_, __) => const HomePage(),
      routes: const [],
    ),
    GoRoute(
      path: RouteNames.changePassword,
      name: RouteNames.changePassword,
      builder: (_, __) => const ChangePasswordPage(),
    ),
  ],

  /// 🚫 Error Handling
  errorBuilder:
      (_, state) => PageNotFound(errorMessage: state.error.toString()),
);
