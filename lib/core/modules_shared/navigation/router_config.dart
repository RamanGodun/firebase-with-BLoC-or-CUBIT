import 'core/app_router.dart';

/// 🧭 [AppRouterConfig] — Entry point for GoRouter integration with [MaterialApp.router]
/// ✅ Used in `MaterialApp.router()`

/// Provides the core routing components:
/// - `routerDelegate`
/// - `routeInformationParser`
/// - `routeInformationProvider`
//----------------------------------------------------------------

final class AppRouterConfig {
  const AppRouterConfig._();

  ///
  static final router = goRouter;

  static final delegate = goRouter.routerDelegate;
  static final parser = goRouter.routeInformationParser;
  static final provider = goRouter.routeInformationProvider;

  ///
}
