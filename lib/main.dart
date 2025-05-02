import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'core/di/bootstrap.dart';
import 'core/di/di_container.dart';
import 'features/presentation/auth_bloc/auth_bloc.dart';
import 'features/presentation/theme_feature/theme_cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🧱 Initialize Firebase, HydratedStorage & BLoC Observer
  await bootstrapApp();

  /// 🔌 Register global services & singletons via GetIt
  await initDIContainer();

  /// 🚀 Launch the root app
  runApp(const RootProviders());
}

/// 🧩 [RootProviders] wraps global BLoC/Cubit providers (from DI)
class RootProviders extends StatelessWidget {
  const RootProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// 🔐 Auth state management (stream from FirebaseAuth)
        BlocProvider.value(value: di<AuthBloc>()),

        /// 🎨 Theme switcher with Hydrated persistence
        BlocProvider.value(value: di<AppThemeCubit>()),
      ],
      child: const AppRootView(),
    );
  }
}
