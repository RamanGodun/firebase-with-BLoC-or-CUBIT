import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/modules_shared/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import 'root_widget.dart';
import 'start_up_handler.dart';
import 'core/modules_shared/di_container/di_container.dart';
import 'core/modules_shared/localization/app_localization.dart';
import 'core/layers_shared/presentation_layer_shared/widgets_shared/app_loaders.dart';
import 'features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'core/modules_shared/theme/theme_cubit/theme_cubit.dart';

/// 🏁 Entry point of the application.
/// ✅ Performs synchronous bootstrapping and launches the app.

void main() async {
  //
  /// Splash loader till the app init end
  runApp(const LoaderWidget(wrapInMaterialApp: true));

  /// 🔌 Firebase + HydratedBloc + Bloc Observer
  await StartUpHandler.bootstrap();

  /// 🚀 Run App
  runApp(AppLocalization.wrap(const RootProviders()));

  ///
}

/// 🌳📦 [RootProviders] — Wraps global Blocs for app-wide access
final class RootProviders extends StatelessWidget {
  const RootProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AuthCubit>()), // 🔐 Auth State
        BlocProvider.value(value: di<AppThemeCubit>()), // 🎨 Theme State
        BlocProvider.value(value: di<OverlayStatusCubit>()),
      ],
      child: const AppRootBuilder(),
    );
  }
}
