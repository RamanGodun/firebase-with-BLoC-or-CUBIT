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

  final LocalizationConfig localization;
  final AppThemesScheme theme;
  final GoRouter router;

  const AppRootConfig({
    required this.localization,
    required this.theme,
    required this.router,
  });
  //

  /// 🏭 Factory method that builds [AppRootConfig] from Riverpod/Bloc + Flutter context.
  factory AppRootConfig.from({
    required BuildContext context,
    required AppThemeState themeState,
  }) {
    ///
    final localization = LocalizationConfig.fromContext(context);

    ///
    final theme = AppThemeBuilder.from(themeState); // ? when using BLoC
    // final theme = AppThemeBuilder.from(
    //       ThemeModeAdapter(ref.watch(themeModeProvider)), //  ? when using Riverpod

    ///
    final router = AppRouterConfig.router; // ? when using BLoC
    //  final router = ref.watch(goRouter); // ? when use Riverpod

    ///
    return AppRootConfig(
      localization: localization,
      theme: theme,
      router: router,
    );
  }

  //
}
