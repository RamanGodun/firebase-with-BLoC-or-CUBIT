import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'core/app_configs/app_root_config.dart';
import 'core/modules_shared/localization/generated/locale_keys.g.dart';
import 'core/modules_shared/overlays/core/global_overlay_handler.dart';
import 'core/modules_shared/navigation/core/_router_config.dart';
import 'core/modules_shared/theme/theme_cubit/theme_cubit.dart';

/// 🌳🧩 [AppRootViewWrapper] — Top-level reactive widget listening to [AppThemeCubit].
/// ✅ Delegates config creation to [AppRootConfig.from].

final class AppRootViewWrapper extends StatelessWidget {
  ///------------------------------------------------
  const AppRootViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RouterCubit, GoRouter, GoRouter>(
      selector: (router) => router,
      builder: (context, router) {
        return BlocSelector<AppThemeCubit, AppThemeState, ThemeMode>(
          selector: (themeState) => themeState.mode,
          builder: (context, themeMode) {
            return _AppRootView(router: router, themeMode: themeMode);
          },
        );
      },
    );
  }
}

////

////

/// 📱🧱 [_AppRootView] — Final stateless [MaterialApp.router] widget.
/// ✅ Receives fully resolved config: theme + router + localization.

final class _AppRootView extends StatelessWidget {
  ///----------------------------------------------

  // final ThemeData theme;
  // final ThemeData darkTheme;
  final ThemeMode themeMode;
  final GoRouter router;

  const _AppRootView({
    // required this.theme,
    // required this.darkTheme,
    required this.themeMode,
    required this.router,
  });
  //

  @override
  Widget build(BuildContext context) {
    ///

    return MaterialApp.router(
      //
      title: LocaleKeys.app_title.tr(),
      debugShowCheckedModeBanner: !kReleaseMode,

      /// 🌐  Localization config
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      /// 🎨 Theme configuration
      // theme: theme,
      // darkTheme: darkTheme,
      themeMode: themeMode,

      /// 🔁 GoRouter configuration
      routerConfig: router,

      // 🧩 Overlay handlings
      builder: (context, child) => GlobalOverlayHandler(child: child!),

      //
    );
  }
}
