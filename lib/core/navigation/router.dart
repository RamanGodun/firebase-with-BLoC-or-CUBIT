part of './_imports_for_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/${RoutesNames.splash}',
  debugLogDiagnostics: true,
  refreshListenable: GoRouterRefreshBloc(appSingleton<AuthBloc>().stream),

  /// 🧭 Refactored redirect logic
  redirect:
      (context, state) => handleAuthRedirect(
        authBloc: appSingleton<AuthBloc>(),
        currentPath: state.matchedLocation,
      ),

  /// 🗺️ Routes
  routes: [
    GoRoute(
      path: '/${RoutesNames.splash}',
      name: RoutesNames.splash,
      pageBuilder: (_, __) => fadeTransitionPage(const SplashPage()),
    ),

    ShellRoute(
      // path: '/app',
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/${RoutesNames.home}',
          name: RoutesNames.home,
          pageBuilder: (context, state) => fadeTransitionPage(const HomePage()),
          routes: [
            GoRoute(
              path: RoutesNames.profile,
              name: RoutesNames.profile,
              pageBuilder:
                  (context, state) => fadeTransitionPage(const ProfilePage()),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/${RoutesNames.signIn}',
      name: RoutesNames.signIn,
      pageBuilder: (context, state) => fadeTransitionPage(const SignInPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.signUp}',
      name: RoutesNames.signUp,
      pageBuilder: (context, state) => fadeTransitionPage(const SignUpPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.resetPassword}',
      name: RoutesNames.resetPassword,

      pageBuilder:
          (context, state) => fadeTransitionPage(const ResetPasswordPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.verifyEmail}',
      name: RoutesNames.verifyEmail,
      pageBuilder:
          (context, state) => fadeTransitionPage(const VerifyEmailPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.changePassword}',
      name: RoutesNames.changePassword,
      pageBuilder:
          (context, state) => fadeTransitionPage(const ChangePasswordPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.pageNotFound}',
      name: RoutesNames.pageNotFound,
      pageBuilder:
          (context, state) =>
              fadeTransitionPage(const PageNotFound(errorMessage: 'Test')),
    ),
  ],

  /// ❌ Fallback for unmatched routes
  errorPageBuilder:
      (context, state) => fadeTransitionPage(
        PageNotFound(errorMessage: state.error?.toString() ?? 'Unknown error'),
      ),
);
