import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'core/shared_modules/theme/theme_cubit/theme_cubit.dart';

/// 🟢 Initializes environment, DI, and runs app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔌 Firebase + HydratedBloc + Bloc Observer
  await bootstrapApp();

  /// 📦 Dependency Injection (GetIt)
  await initDIContainer();

  /// 🚀 Run App
  runApp(const RootProviders());
}

/// 🌐 [RootProviders] — Wraps global Blocs for app-wide access
class RootProviders extends StatelessWidget {
  const RootProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AuthBloc>()), // 🔐 Auth State
        BlocProvider.value(value: di<AppThemeCubit>()), // 🎨 Theme State
      ],
      child: const AppRootView(),
    );
  }
}

/*
! DIALOGS AND SNACKBARS
._()

 */
