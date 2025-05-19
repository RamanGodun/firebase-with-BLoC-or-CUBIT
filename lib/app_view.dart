import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/shared_modules/app_overlays/core/global_overlay_handler.dart';
import 'core/shared_modules/app_theme/config/app_theme_config.dart';
import 'core/shared_modules/app_navigation/router_config.dart';
import 'core/shared_modules/app_theme/config/app_material_theme.dart';
import 'core/shared_modules/app_theme/theme_cubit/theme_cubit.dart';

/// 🎛️ [AppRootView] — Root UI widget, delegates logic to [AppThemeBuilder].
final class AppRootView extends StatelessWidget {
  const AppRootView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppThemeBuilder();
  }
}

/// 📱 AppThemeBuilder — Rebuilds UI on theme mode toggle
final class AppThemeBuilder extends StatelessWidget {
  const AppThemeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      buildWhen: (prev, curr) => prev.isDarkTheme != curr.isDarkTheme,
      builder: (context, state) {
        final config = AppConfig.fromState(state);
        return AppMaterialAppRouter(config: config);
      },
    );
  }
}

/// 🧩 [AppMaterialAppRouter] —  Centralized theme + navigation config
final class AppMaterialAppRouter extends StatelessWidget {
  final AppThemeConfig config;
  const AppMaterialAppRouter({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: config.title,
      debugShowCheckedModeBanner: config.debugShowCheckedModeBanner,

      /// 🎨 Theme configuration
      theme: config.theme,
      darkTheme: config.darkTheme,
      themeMode: config.themeMode,

      /// 🔁 GoRouter configuration
      routerDelegate: AppRouterConfig.delegate,
      routeInformationParser: AppRouterConfig.parser,
      routeInformationProvider: AppRouterConfig.provider,

      /// 🌐  Localization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      ///
      builder: (context, child) => GlobalOverlayHandler(child: child!),
    );
  }
}
