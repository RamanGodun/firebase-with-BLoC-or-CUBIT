import 'package:flutter/material.dart' show BuildContext, immutable;
import 'package:go_router/go_router.dart' show GoRouter;
import '../shared_modules/theme/theme_cubit/theme_cubit.dart';
import 'localization_config.dart';
import 'router_config.dart';
import 'theme_config.dart';

/// 🧩 [AppRootConfig] — Immutable global app configuration passed to [MaterialApp].
@immutable
final class AppRootConfig {
  final AppThemeConfig theme;
  final LocalizationConfig localization;
  final GoRouter router;

  const AppRootConfig({
    required this.theme,
    required this.localization,
    required this.router,
  });

  /// 🏭 Factory that extracts theme + localization from context and cubit state
  factory AppRootConfig.from({
    required BuildContext context,
    required AppThemeState themeState,
  }) {
    final theme = ThemeConfig.fromState(themeState);
    final localization = LocalizationConfig.fromContext(context);
    final router = AppRouterConfig.router;

    return AppRootConfig(
      theme: theme,
      localization: localization,
      router: router,
    );
  }

  //
}
