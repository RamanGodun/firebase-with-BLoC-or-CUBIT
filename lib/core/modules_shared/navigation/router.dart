part of '_imports_for_router.dart';

/// 🚦 [goRouter] — Main GoRouter instance for the app
/// Responsible for:
/// - ✅ Initial route configuration
/// - 🔄 Handling auth-based redirects
/// - 🧱 Shell layout scaffolding
/// - 🗺️ Declarative route definitions
/// - ❌ Custom error page fallback
//---------------------------------------------------------------

final GoRouter goRouter = GoRouter(
  /// 👁️ Observers — Navigation side-effects
  /// - ✅ Auto-clears overlays on push/pop/replace (OverlayDispatcher)
  observers: [OverlayNavigatorObserver()],

  /// ⏳ Initial route (Splash Screen)
  initialLocation: '/${RoutesNames.splash}',

  /// 🐞 Enable GoRouter debug logs (only in debug mode)
  debugLogDiagnostics: true,

  /// 🔄 Refresh when auth state changes (listens to AuthBloc stream)
  refreshListenable: GoRouterRefresher(di<AuthBloc>().stream),

  /// 🔐 Redirects based on current auth state
  redirect:
      (context, state) => AuthRedirectMapper.from(
        authBloc: di<AuthBloc>(),
        currentPath: state.matchedLocation,
      ),

  /// 🗺️ Route Map — Declare all navigable paths
  routes: [
    /// ⏳ Splash Page
    GoRoute(
      path: '/${RoutesNames.splash}',
      name: RoutesNames.splash,
      pageBuilder: (_, _) => AppTransitions.fade(const SplashPage()),
    ),

    /// 🧱 Shell Layout (Main App Scaffold)
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        /// 🏠 Home Page
        GoRoute(
          path: '/${RoutesNames.home}',
          name: RoutesNames.home,
          pageBuilder:
              (context, state) => AppTransitions.fade(const HomePage()),
          routes: [
            /// 👤 Profile Page (Nested under Home)
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

    /// 🔐 Auth Pages
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

    /// ❌ Error / 404 Page
    GoRoute(
      path: '/${RoutesNames.pageNotFound}',
      name: RoutesNames.pageNotFound,
      pageBuilder:
          (context, state) =>
              AppTransitions.fade(const PageNotFound(errorMessage: 'Test')),
    ),
  ],

  /// ❌ Fallback: Unmatched route or navigation error
  errorPageBuilder:
      (context, state) => AppTransitions.fade(
        PageNotFound(errorMessage: state.error?.toString() ?? 'Unknown error'),
      ),

  ///
);

/*


redirect: (context, state) {
  final status = di<AuthBloc>().state.authStatus;
  return AuthRedirectMapper.from(
    isAuthenticated: status == AuthStatus.authenticated,
    isVerified: di<AuthBloc>().state.isVerified,
    isLoading: status == AuthStatus.unknown,
    isError: false,
    currentPath: state.matchedLocation,
  );
}


 */
