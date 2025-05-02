import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'features/auth/presentation/auth/auth_bloc/auth_bloc.dart';
import 'core/shared_moduls/theme/theme_cubit/theme_cubit.dart';

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
