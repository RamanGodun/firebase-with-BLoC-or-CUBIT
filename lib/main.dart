import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/bootstrap.dart';
import 'core/di/injection.dart';
import 'core/navigation/router.dart';
import 'features/auth/auth_bloc/auth_bloc.dart';
import 'features/profile/profile_bloc/profile_cubit.dart';
import 'features/sign_in/sign_in_bloc/signin_cubit.dart';
import 'features/sign_up/signup_bloc/signup_cubit.dart';
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
/// Registers all BLoC/Cubit instances using GetIt ([appSingleton]).
class AppBlocProviders extends StatelessWidget {
  const AppBlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => appSingleton<AuthBloc>()),
        BlocProvider(create: (_) => appSingleton<SigninCubit>()),
        BlocProvider(create: (_) => appSingleton<SignupCubit>()),
        BlocProvider(create: (_) => appSingleton<ProfileCubit>()),
        BlocProvider(create: (_) => appSingleton<AppThemeCubit>()),
      ],
      child: const AppView(),
    );
  }
}

/// * 🎨 [AppView] - builds the main [MaterialApp] structure.
/// - lListens for theme changes via **AppSettingsCubit**.
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.getLightTheme(),
          darkTheme: AppThemes.getDarkTheme(),
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

          ///
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        );
      },
    );
  }
}
