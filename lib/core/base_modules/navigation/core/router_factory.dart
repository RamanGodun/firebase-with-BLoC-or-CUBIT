import 'package:go_router/go_router.dart';
import '../../../../app_bootstrap_and_config/firebase_config/user_auth_cubit/auth_cubit.dart';
import '../../../shared_presentation_layer/pages_shared/page_not_found.dart';
import '../app_routes/app_routes.dart';
import '../utils/overlay_navigation_observer.dart';
import 'routes_redirection_service.dart';

/// 🧭 [buildGoRouter] — Фабрика GoRouter. Створює роутер залежно від актуального [AuthState].
/// ✅ Жодних refreshListenable. Все декларативно!
GoRouter buildGoRouter(AuthState authState) {
  return GoRouter(
    /// 👁️ Observers — navigation side-effects (e.g., dismissing overlays)
    observers: [OverlayNavigatorObserver()],

    /// 🐞 Enable verbose logging for GoRouter (only active in debug mode)
    debugLogDiagnostics: true,

    /// ⏳ Initial route shown on app launch (Splash Screen)
    initialLocation: RoutesPaths.splash,

    /// 🗺️ Route definitions used across the app
    routes: AppRoutes.all,

    /// ❌ Fallback UI for unknown/unmatched routes
    errorBuilder:
        (context, state) => PageNotFound(errorMessage: state.error.toString()),

    /// 🔁 Triggers route evaluation when `authState` changes
    // refreshListenable: GoRouterRefresher(authCubit.stream),

    /// 🧭 Global redirect handler — routes user depending on auth state
    redirect:
        (context, state) =>
            RoutesRedirectionService.from(context, state, authState),
  );
}
