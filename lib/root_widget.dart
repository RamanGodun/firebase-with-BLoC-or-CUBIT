import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'core/modules_shared/localization/generated/locale_keys.g.dart';
import 'core/modules_shared/overlays/core/global_overlay_handler.dart';
import 'core/modules_shared/navigation/core/router_cubit.dart';
import 'core/modules_shared/theme/_theme_preferences.dart';
import 'core/modules_shared/theme/theme_cubit.dart';

/// 🌳🧩 [AppRootViewWrapper] — Top-level reactive widget listening to [AppThemeCubit].
/// ✅ Delegates config creation to [AppRootConfig.from].

final class AppRootViewWrapper extends StatelessWidget {
  ///------------------------------------------------
  const AppRootViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return BlocSelector<RouterCubit, GoRouter, GoRouter>(
      selector: (router) => router,
      builder: (context, router) {
        return BlocSelector<AppThemeCubit, ThemePreferences, ThemePreferences>(
          selector: (config) => config,
          builder: (context, config) {
            return _AppRootView(
              router: router,
              lightTheme: config.buildLight(),
              darkTheme: config.buildDark(),
              themeMode: config.mode,
            );
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

  final GoRouter router;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  const _AppRootView({
    required this.router,
    required this.lightTheme,
    required this.darkTheme,
    required this.themeMode,
  });
  //

  @override
  Widget build(BuildContext context) {
    ///
    print('[🧪 THEME] themeMode: $themeMode');
    print('[🧪 THEME] light theme: ${lightTheme.brightness}');
    print('[🧪 THEME] dark theme: ${darkTheme.brightness}');

    return MaterialApp.router(
      //
      title: LocaleKeys.app_title.tr(),
      debugShowCheckedModeBanner: !kReleaseMode,

      /// 🌐  Localization config
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      /// 🎨 Theme configuration
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      /// 🔁 GoRouter configuration
      routerConfig: router,

      // 🧩 Overlay handlings
      builder: (context, child) => GlobalOverlayHandler(child: child!),

      //
    );
  }
}
