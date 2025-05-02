import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils_and_services/overlay/focus_overlay_dismiss_wrapper.dart';
import 'features/presentation/theme_feature/config/app_theme_config.dart';
import 'core/navigation/router_config.dart';
import 'features/presentation/theme_feature/config/app_material_theme.dart';
import 'features/presentation/theme_feature/theme_cubit/theme_cubit.dart';

/// 📦 [AppRootView] — Root UI widget. Delegates logic to [AppThemeBuilder].
class AppRootView extends StatelessWidget {
  const AppRootView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppThemeBuilder();
  }
}

/// 🎛️ [AppThemeBuilder] — Listens for [AppThemeCubit] and triggers UI rebuild.
class AppThemeBuilder extends StatelessWidget {
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

/// 🧩 [AppMaterialAppRouter] — MaterialApp.router configured via [AppThemeConfig].
class AppMaterialAppRouter extends StatelessWidget {
  const AppMaterialAppRouter({super.key, required this.config});

  final AppThemeConfig config;

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

      ///
      builder: (context, child) => FocusAndOverlayDismissWrapper(child: child!),
    );
  }
}



/*
? option for prototyping, small MVP, or PoC

/// 🗺️ [AppView] - root app view, listens for theme changes and builds [MaterialApp]
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        final config = AppConfig.materialTheme(state);

        return MaterialApp.router(
          title: config.title,
          debugShowCheckedModeBanner: config.debugShowCheckedModeBanner,

          /// 🎨 Theme configuration
          theme: config.theme,
          darkTheme: config.darkTheme,
          themeMode: config.themeMode,

          /// 🔁 GoRouter configuration
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,

          ///
          builder: (context, child) => FocusAndOverlayDismissWrapper(child: child!),
        );
      },
    );
  }
}
 */