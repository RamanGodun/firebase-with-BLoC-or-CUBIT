import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/base_modules/localization/app_localization.dart';
import 'core/shared_domain_layer/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import 'core/base_modules/navigation/core/router_cubit.dart';
import 'core/base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import 'core/base_modules/theme/theme_cubit.dart';
import 'root_view_shell.dart';
import 'app_bootstrap_and_config/app_bootstrap.dart';
import 'app_bootstrap_and_config/di_container/di_container.dart';

/// 🏁 Entry point of the application
void main() async {
  ///
  final appBootstrap = const AppBootstrap(
    // ? Here can be plugged in custom dependencies (e.g.  "localStorage: IsarLocalStorage()," )
  );

  /// 🚀 Runs all startup logic (localization, Firebase, full DI container, debug tools, local storage, etc).
  await appBootstrap.initAllServices();

  /// 🏁 Launches app
  runApp(const AppLocalizationShell());
  //
}

////

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

////

/// 📦 [GlobalProviders] — Wraps all global Blocs with providers for the app
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
