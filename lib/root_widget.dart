import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_configs/app_root_config.dart';
import 'core/modules_shared/overlays/core/global_overlay_handler.dart';
import 'core/modules_shared/navigation/core/_router_config.dart';
import 'core/modules_shared/theme/theme_cubit/theme_cubit.dart';

/// 🌳🧩 [AppRootBuilder] — Top-level reactive widget listening to [AppThemeCubit].
/// ✅ Delegates config creation to [AppRootConfig.from].

final class AppRootBuilder extends StatelessWidget {
  ///----------------------------------------------

  const AppRootBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    // ? Theme memoization
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      buildWhen: (prev, curr) => prev != curr,

      builder: (context, state) {
        final config = AppRootConfig.from(context: context, themeState: state);
        return _AppRootView(config: config);
      },
    );
  }
}

///

/// 📱🧱 [_AppRootView] — Final wrapper for MaterialApp.router
///   ✅ Configured from [AppRootConfig].

final class _AppRootView extends StatelessWidget {
  ///----------------------------------------------

  final AppRootConfig config;
  const _AppRootView({required this.config});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: config.localization.title,
      debugShowCheckedModeBanner: !kReleaseMode,

      /// 🎨 Theme configuration
      theme: config.theme.theme,
      darkTheme: config.theme.darkTheme,
      themeMode: config.theme.themeMode,

      /// 🔁 GoRouter configuration
      routerDelegate: AppRouterConfig.delegate,
      routeInformationParser: AppRouterConfig.parser,
      routeInformationProvider: AppRouterConfig.provider,

      /// 🌐  Localization
      locale: config.localization.locale,
      supportedLocales: config.localization.supportedLocales,
      localizationsDelegates: config.localization.delegates,

      // 🧩 Overlay handlings
      builder: (context, child) => GlobalOverlayHandler(child: child!),

      //
    );
  }
}
