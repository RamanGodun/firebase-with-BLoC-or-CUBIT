import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'core/base_modules/localization/generated/locale_keys.g.dart';
import 'core/base_modules/overlays/core/global_overlay_handler.dart';
import 'core/base_modules/navigation/core/router_cubit.dart';
import 'core/base_modules/theme/_theme_preferences.dart';
import 'core/base_modules/theme/theme_cubit.dart';

/// 🌳🧩 [AppRootViewShell] — Top-level reactive widget listening to [AppThemeCubit].
/// ✅ Delegates config creation to [AppRootConfig.from].

final class AppRootViewShell extends StatelessWidget {
  ///------------------------------------------------
  const AppRootViewShell({super.key});

  @override
  Widget build(BuildContext context) {
    ///
    // Listen to navigation state (GoRouter) from RouterCubit.
    return BlocSelector<RouterCubit, GoRouter, GoRouter>(
      selector: (router) => router,
      builder: (context, router) {
        // Listen to current theme preferences from AppThemeCubit.
        return BlocSelector<AppThemeCubit, ThemePreferences, ThemePreferences>(
          selector: (config) => config,
          builder: (context, config) {
            // Pass all resolved config (router + theme) to root view.
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
    return MaterialApp.router(
      ///
      title: LocaleKeys.app_title.tr(),
      debugShowCheckedModeBanner: !kReleaseMode,

      /// 🌐  Localization setup via EasyLocalization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      /// 🎨 Theme configuration
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      /// 🔁 Router setup for declarative navigation
      routerConfig: router,

      /// 🧩 Overlay handler for global overlays
      builder: (context, child) => GlobalOverlayHandler(child: child!),

      //
    );
  }
}
