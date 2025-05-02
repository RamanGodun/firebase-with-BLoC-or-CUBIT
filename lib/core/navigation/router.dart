part of './_imports_for_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/${RoutesNames.splash}',
  debugLogDiagnostics: true,
  refreshListenable: GoRouterRefresher(appSingleton<AuthBloc>().stream),

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
      pageBuilder: (_, __) => AppTransitions.fade(const SplashPage()),
    ),

    ShellRoute(
      // path: '/app',
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/${RoutesNames.home}',
          name: RoutesNames.home,
          pageBuilder:
              (context, state) => AppTransitions.fade(const HomePage()),
          routes: [
            GoRoute(
              path: RoutesNames.profile,
              name: RoutesNames.profile,
              pageBuilder:
                  (context, state) => AppTransitions.fade(const ProfilePage()),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/${RoutesNames.signIn}',
      name: RoutesNames.signIn,
      pageBuilder: (context, state) => AppTransitions.fade(const SignInPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.signUp}',
      name: RoutesNames.signUp,
      pageBuilder: (context, state) => AppTransitions.fade(const SignUpPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.resetPassword}',
      name: RoutesNames.resetPassword,

      pageBuilder:
          (context, state) => AppTransitions.fade(const ResetPasswordPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.verifyEmail}',
      name: RoutesNames.verifyEmail,
      pageBuilder:
          (context, state) => AppTransitions.fade(const VerifyEmailPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.changePassword}',
      name: RoutesNames.changePassword,
      pageBuilder:
          (context, state) => AppTransitions.fade(const ChangePasswordPage()),
    ),
    GoRoute(
      path: '/${RoutesNames.pageNotFound}',
      name: RoutesNames.pageNotFound,
      pageBuilder:
          (context, state) =>
              AppTransitions.fade(const PageNotFound(errorMessage: 'Test')),
    ),
  ],

  /// ❌ Fallback for unmatched routes
  errorPageBuilder:
      (context, state) => AppTransitions.fade(
        PageNotFound(errorMessage: state.error?.toString() ?? 'Unknown error'),
      ),
);
