import 'package:go_router/go_router.dart';
import '../../../layers_shared/domain_shared/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../../di_container/di_container.dart';
import '../utils/overlay_navigation_observer.dart';
import '../app_routes/app_routes.dart';
import '../utils/routes_redirection_service.dart';
import '../../../layers_shared/domain_shared/auth_state_refresher/auth_state_refresher.dart'
    show AuthStateRefresher;

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
