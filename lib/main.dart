import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/bootstrap.dart';
import 'core/di/injection.dart';
import 'core/navigation/router.dart';
import 'features/auth_bloc/auth_bloc.dart';
import 'core/constants/app_strings.dart';
import 'features/theme/app_theme.dart';
import 'features/theme/theme_cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔧 Initialize Firebase + HydratedStorage + BLoC observer
  await bootstrapApp();

  /// 🧩 Register all dependencies via GetIt
  await initDependencies();

  /// 🏁 **Launch the app**
  runApp(const AppBlocProviders());
}

/// * 🧱 Root BLoC provider wrapper.
class AppBlocProviders extends StatelessWidget {
  const AppBlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// *  Registers all BLoC/Cubit instances using GetIt ([appSingleton]).
        /// 🧑‍💼 AuthBloc and  🎨 AppThemeCubit (singletons,  used globally)
        BlocProvider.value(value: appSingleton<AuthBloc>()),
        BlocProvider.value(value: appSingleton<AppThemeCubit>()),
      ],
      child: const AppView(),
    );
  }
}

/// * 🗾 [AppView] - builds the main [MaterialApp] structure.
///   Listens for theme changes via **AppSettingsCubit**.
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,

          /// 🎨 Theme settings
          theme: AppThemes.getLightTheme(),
          darkTheme: AppThemes.getDarkTheme(),
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

          /// 🌐 Navigation settings
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        );
      },
    );
  }
}
