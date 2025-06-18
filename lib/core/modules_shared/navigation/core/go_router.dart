import 'package:go_router/go_router.dart';
import '../../../layers_shared/domain_shared/auth_state_cubit/auth_cubit.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../../di_container/di_container.dart';
import '../utils/overlay_navigation_observer.dart';
import 'routes.dart';
import 'routes_names.dart';
import '../utils/router_redirect.dart';
import 'router_refresher.dart' show GoRouterRefresher;

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
  initialLocation: RoutesPaths.splash,

  /// 🐞 Enable GoRouter debug logs (only in debug mode)
  debugLogDiagnostics: true,

  /// 🔄 Refresh when auth state changes (listens to AuthBloc stream)
  refreshListenable: GoRouterRefresher(di<AuthCubit>().stream),
  // BlocRefresher()..bind(authCubit.stream);

  /// 🧭 Redirect logic handled by [RoutesRedirectionService], based on auth state
  redirect: (context, state) {
    final authState = di<AuthCubit>().state;
    return RoutesRedirectionService.from(
      authStatus: authState.authStatus,
      currentPath: state.matchedLocation,
    );
  },

  /// 🗺️ Route Map — Declare all navigable paths
  routes: AppRoutes.all,

  /// ❌ Wildcard handler for unmatched routes
  errorBuilder:
      (context, state) => PageNotFound(errorMessage: state.error.toString()),

  //
);
