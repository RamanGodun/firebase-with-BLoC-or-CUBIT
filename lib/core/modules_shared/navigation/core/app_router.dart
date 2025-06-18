import 'package:go_router/go_router.dart';
import '../../../../features/auth/presentation/auth_bloc/auth_cubit.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../../di_container/di_container.dart';
import '../utils/overlay_navigation_observer.dart';
import 'app_routes.dart';
import 'routes_names.dart';
import '../utils/router_redirect.dart';
import 'router_refresher.dart' show AuthCubitAdapter;

/// 🧭🚦 [goRouter] — Main GoRouter instance for the app
/// Responsible for:
/// - ✅ Initial route configuration
/// - 🔄 Handling auth-based redirects
/// - 🧱 Shell layout scaffolding
/// - 🗺️ Declarative route definitions
/// - ❌ Custom error page fallback

final GoRouter goRouter = GoRouter(
  //------------------------------

  /// 👁️ Observers — Navigation side-effects
  /// - ✅ Auto-clears overlays on push/pop/replace (OverlayDispatcher)
  observers: [OverlayNavigatorObserver()],

  /// ⏳ Initial route (Splash Screen)
  initialLocation: '/${RoutesNames.splash}',

  /// 🐞 Enable GoRouter debug logs (only in debug mode)
  debugLogDiagnostics: true,

  /// 🔄 Refresh when auth state changes (listens to AuthBloc stream)
  // refreshListenable: GoRouterRefresher(di<AuthCubit>().stream),
  refreshListenable: AuthCubitAdapter(di<AuthCubit>()),

  /// 🧭 Redirect logic handled by [RoutesRedirectionService], based on auth state
  redirect:
      (context, state) => AuthRedirectMapper.from(
        authCubit: di<AuthCubit>(),
        currentPath: state.matchedLocation,
      ),

  /// 🗺️ Route Map — Declare all navigable paths
  routes: AppRoutes.all,

  /// ❌ Wildcard handler for unmatched routes
  errorBuilder:
      (context, state) => PageNotFound(errorMessage: state.error.toString()),

  //
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
