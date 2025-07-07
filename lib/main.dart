import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/layers_shared/domain_shared/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import 'core/modules_shared/navigation/core/router_cubit.dart';
import 'core/modules_shared/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import 'root_widget.dart';
import 'start_up_bootstrap.dart';
import 'core/modules_shared/di_container/di_container.dart';
import 'core/modules_shared/localization/app_localization.dart';
import 'core/layers_shared/presentation_layer_shared/widgets_shared/loader.dart';
import 'core/modules_shared/theme/theme_cubit.dart';

/// 🏁 Entry point of the application.
/// ✅ Performs synchronous bootstrapping and launches the app.

void main() async {
  ///
  WidgetsFlutterBinding.ensureInitialized();
  //
  // Splash loader till the app init end
  runApp(const AppLoader(wrapInMaterialApp: true));

  // 📦 Initializes app dependencies via GetIt
  await AppDI.init();

  /// 🚀 Runs all imperative startup logic (localization, Firebase, storage, etc).
  /// StartupHandler can access DI from globalContainer outside context.
  final startUpHandler = const DefaultStartUpHandler(
    // ? Here can be plugged in custom dependencies, e.g.:
    // firebaseStack: MockFirebaseStack(),
    // debugTools: FakeDebugTools(),
  );
  await startUpHandler.bootstrap();

  /// 🚀 Run App
  runApp(AppLocalization.wrap(const RootProviders()));

  ///
}

////

////

/// 🌳📦 [RootProviders] — Wraps global Blocs for app-wide access
final class RootProviders extends StatelessWidget {
  ///--------------------------------------------
  const RootProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AuthCubit>()), // 🔐 Auth State
        BlocProvider.value(value: di<RouterCubit>()), // 🧭🚦 Router
        BlocProvider.value(value: di<AppThemeCubit>()), // 🎨 Theme State

        BlocProvider.value(value: di<OverlayStatusCubit>()),
      ],
      child: const AppRootViewWrapper(),
    );
  }
}
