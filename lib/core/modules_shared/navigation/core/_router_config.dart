import 'go_router.dart';

/// 🧭 [AppRouterConfig] — Wrapper for router provider.
/// ✅ Entry point for GoRouter integration with [MaterialApp.router]
/// ✅ Enables consistent API across Bloc / Riverpod apps.

final class AppRouterConfig {
  ///------------------------
  const AppRouterConfig._();
  //

  /// 🧩 Global router instance
  static final router = goRouter;

  /// 💡 Access actual GoRouter object for Riverpod (read-only)
  // static GoRouter use(WidgetRef ref) => ref.watch(goRouterProvider);

  /// Provides the core routing components:
  /// - `routerDelegate`
  /// - `routeInformationParser`
  /// - `routeInformationProvider`

  /// ✅ Bloc (if you need delegate/parser/provider explicitly)
  /// Provides the core routing components:
  /// - `routerDelegate`
  /// - `routeInformationParser`
  /// - `routeInformationProvider`
  static final delegate = goRouter.routerDelegate;
  static final parser = goRouter.routeInformationParser;
  static final provider = goRouter.routeInformationProvider;

  //
}
