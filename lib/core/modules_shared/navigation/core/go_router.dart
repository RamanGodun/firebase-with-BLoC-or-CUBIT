part of '_router_config.dart';

class GoRouterRefresher extends ChangeNotifier {
  GoRouterRefresher(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}

/////

/*


/// 🧭🚦 [goRouter] — GoRouter configuration with global auth-aware redirect

final GoRouter goRouter = GoRouter(
  ///-----------------------------

  /// 👁️ Observers — navigation side-effects (e.g., dismissing overlays)
  observers: [OverlayNavigatorObserver()],

  /// 🐞 Enable verbose logging for GoRouter (only active in debug mode)
  debugLogDiagnostics: true,

  ///

  // ⏳ Initial route shown on app launch (Splash Screen)
  initialLocation: RoutesPaths.splash,

  /// 🗺️ Route definitions used across the app
  routes: AppRoutes.all,

  /// ❌ Fallback UI for unknown/unmatched routes
  errorBuilder:
      (context, state) => PageNotFound(errorMessage: state.error.toString()),

  ///

  /// 🔁 Triggers route evaluation when `authState` changes
  refreshListenable: AuthStateRefresher(di<AuthCubit>().stream),
  // BlocRefresher()..bind(authCubit.stream);

  /// 🧭 Global redirect handler — routes user depending on auth state
  redirect: (context, state) {
    final authState = di<AuthCubit>().state;
    return RoutesRedirectionService.from(context, state, authState);
  },

  //
);

 */
