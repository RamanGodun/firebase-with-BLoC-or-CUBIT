import 'package:flutter/material.dart' show BuildContext, immutable;
import 'package:go_router/go_router.dart' show GoRouter;
import '../modules_shared/theme/theme_cubit/theme_cubit.dart';
import '../modules_shared/localization/localization_config.dart';
import '../modules_shared/navigation/core/_router_config.dart';
import '../modules_shared/theme/core/_theme_config.dart';

/// 🧩 [AppRootConfig] — Immutable object holding all global config required by [MaterialApp].
/// ✅ Clean separation of logic & widget layer, with convenient factory for Riverpod or Bloc integration.

@immutable
final class AppRootConfig {
  ///--------------------

  final AppThemesScheme theme;
  final LocalizationConfig localization;
  final GoRouter router;

  const AppRootConfig({
    required this.theme,
    required this.localization,
    required this.router,
  });
  //

  /// 🏭 Factory method that builds [AppRootConfig] from Riverpod/Bloc + Flutter context.
  factory AppRootConfig.from({
    required BuildContext context,
    required AppThemeState themeState,
  }) {
    ///
    //
    // ? when use Riverpod state manager, uncomment next:
    // final theme = ThemeConfig.from(ref.watch(themeModeProvider));
    // ? when use BLoC state manager, uncomment next:
    final theme = AppThemeBuilder.from(themeState);

    ///
    final localization = LocalizationConfig.fromContext(context);

    ///
    // ? when use Riverpod state manager, uncomment next:
    // final router = AppRouterConfig.use(ref);
    // ? when use BLoC state manager, uncomment next:
    final router = AppRouterConfig.router;

    ///
    return AppRootConfig(
      theme: theme,
      localization: localization,
      router: router,
    );
  }

  //
}
