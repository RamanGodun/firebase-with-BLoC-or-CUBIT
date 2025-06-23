import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../layers_shared/domain_shared/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../app_routes/app_routes.dart';
import '../utils/overlay_navigation_observer.dart';
import '../utils/routes_redirection_service.dart';

part 'go_router.dart';

class RouterCubit extends Cubit<GoRouter> {
  RouterCubit(AuthCubit authCubit)
    : super(
        GoRouter(
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
              (context, state) =>
                  PageNotFound(errorMessage: state.error.toString()),

          ///

          /// 🔁 Triggers route evaluation when `authState` changes
          refreshListenable: GoRouterRefresher(authCubit.stream),

          /// 🧭 Global redirect handler — routes user depending on auth state
          redirect: (context, state) {
            final authState = authCubit.state;
            return RoutesRedirectionService.from(context, state, authState);
          },

          //
        ),
      );
}
