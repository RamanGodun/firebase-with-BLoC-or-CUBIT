import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'core/shared_modules/app_localization/core/localization_config.dart';
import 'core/shared_modules/app_overlays/presentation/widgets/loaders.dart';
import 'features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'core/shared_modules/app_theme/theme_cubit/theme_cubit.dart';

/// 🟢 Initializes environment, DI, and runs app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Splash loader till the app init end
  runApp(const LoaderWidget(wrapInMaterialApp: true));

  /// 🔌 Firebase + HydratedBloc + Bloc Observer
  await AppBootstrap.initialize();

  /// 📦 Initializes all app dependencies via GetIt
  await AppDI.init();

  /// 🌈 Enables debug painting for layout visualization (repaint regions)
  debugRepaintRainbowEnabled = false;

  /// 🚀 Run App
  runApp(AppLocalization.wrap(const RootProviders()));

  ///
}

/// 🌐 [RootProviders] — Wraps global Blocs for app-wide access
final class RootProviders extends StatelessWidget {
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
⏱ 


 	1.	Реалізую універсальний OverlayHost<T> (для banner/snackbar/dialog)
	2.	Підключу AnimationEngineFactory всередині хоста
	3.	Додам dismiss() API з reverse animation + onDismiss callback
	4.	Оновлю OverlayService, щоб використовував новий хост


 */
