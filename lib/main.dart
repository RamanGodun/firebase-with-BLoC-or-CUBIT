import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/bootstrap.dart';
import 'core/di/injection.dart';
import 'core/navigation/_imports_for_router.dart';
import 'features/auth_bloc/auth_bloc.dart';
import 'core/constants/app_strings.dart';
import 'features/theme/app_theme.dart';
import 'features/theme/theme_cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🧱 Initialize Firebase, HydratedStorage & BLoC Observer
  await bootstrapApp();

  /// 🔌 Register global services & singletons via GetIt
  await initDependencies();

  /// 🚀 Launch the root app
  runApp(const AppBlocProviders());
}

/// 🧩 [AppBlocProviders] wraps global BLoC/Cubit providers (from DI)
class AppBlocProviders extends StatelessWidget {
  const AppBlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// 🔐 Auth state management (stream from FirebaseAuth)
        BlocProvider.value(value: appSingleton<AuthBloc>()),

        /// 🎨 Theme switcher with Hydrated persistence
        BlocProvider.value(value: appSingleton<AppThemeCubit>()),
      ],
      child: const AppView(),
    );
  }
}

/// 🗺️ [AppView] - root app view, listens for theme changes and builds [MaterialApp]
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,

          /// 🎨 Light/Dark theme configuration
          theme: AppThemes.getLightTheme(),
          darkTheme: AppThemes.getDarkTheme(),
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

          /// 🔁 GoRouter configuration
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        );
      },
    );
  }
}
