import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'core/di/bootstrap.dart';
import 'core/di/di_container.dart';
import 'features/auth_bloc/auth_bloc.dart';
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
      child: const RootAppView(),
    );
  }
}
