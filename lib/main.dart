import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/foundation/localization/app_localization.dart';
import 'core/layers_shared/domain_shared/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import 'core/foundation/navigation/core/router_cubit.dart';
import 'core/foundation/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import 'core/foundation/theme/theme_cubit.dart';
import 'root_view_shell.dart';
import 'app_start_up/start_up_bootstrap.dart';
import 'app_start_up/di_container/di_container.dart';

/// 🏁 Entry point of the application
void main() async {
  ///

  /// Imperative initialization
  final startUp = const AppStartUp(
    // ? Here can be plugged in custom dependencies, e.g.:
    // firebaseStack: MockFirebaseStack(),
    // debugTools: FakeDebugTools(),
  );

  ///  Initialize Flutter bindings, debug tools, etc (minimal pre-bootstrap)
  await startUp.run();

  ///  Show initial splash loader with necessary dependencies (local storage and theme Cubit)
  await startUp.showAppInitLoader();

  /// 🚀 Runs all imperative startup logic (localization, Firebase, full DI container, etc).
  await startUp.bootstrap();

  /// 🏁 Launches app
  runApp(const AppLocalizationShell());
  debugPrint('🏁 App fully started');
  //
}

////

/// 🌍✅ [AppLocalizationShell] — Ensures the entire app tree is properly localized before rendering the root UI.

final class AppLocalizationShell extends StatelessWidget {
  ///----------------------------------------------
  const AppLocalizationShell({super.key});

  @override
  Widget build(BuildContext context) {
    //
    /// Injects localization context into the widget tree.
    /// Provides all supported locales and translation assets to [child].
    return AppLocalization.configure(const GlobalProviders());
  }
}

////

/// 🧩📦 [GlobalProviders] — Wraps all global Blocs with providers for the app
final class GlobalProviders extends StatelessWidget {
  ///--------------------------------------------
  const GlobalProviders({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AuthCubit>()),
        BlocProvider.value(value: di<RouterCubit>()),
        BlocProvider.value(value: di<AppThemeCubit>()),
        BlocProvider.value(value: di<OverlayStatusCubit>()),
      ],
      child: const AppRootViewShell(),
    );
  }
}
