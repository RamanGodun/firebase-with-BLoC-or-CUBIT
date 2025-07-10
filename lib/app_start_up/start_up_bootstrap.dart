import 'package:firebase_with_bloc_or_cubit/app_start_up/app_core_initializations/debug_tools.dart'
    show IDebugTools, DebugTools;
import 'package:firebase_with_bloc_or_cubit/app_start_up/app_core_initializations/local_storage.dart'
    show ILocalStorageStack, LocalStorageStack;
import 'package:flutter/material.dart';
import 'app_core_initializations/firebase.dart';
import 'app_core_initializations/localization.dart';
import 'app_core_initializations/others.dart';
import 'app_core_initializations/platform_validation.dart';
import 'app_loader_while_bootstrap/get_theme_for_initial_loader.dart';
import 'app_loader_while_bootstrap/shell_for_init_loader.dart';
import 'di_container/di_container.dart';

/// 🧰 [IAppStartUp] — Abstract contract for app startup logic

abstract interface class IAppStartUp {
  ///----------------------------------
  const IAppStartUp();
  //
  /// Initializes Flutter bindings and debug tools
  Future<void> run();
  //
  /// Shows the initial app shell with loader (splash) till full bootstrap.
  Future<void> showAppInitLoader();
  //
  /// Runs all remaining initialization (localization, DI, Firebase, etc).
  Future<void> bootstrap();
  //
}

////

////

/// 🧰 [AppStartUp] — Handles all critical bootstrapping (with injectable stacks for testing/mocks).

final class AppStartUp implements IAppStartUp {
  ///-------------------------------------------------------
  //
  final IPlatformValidator _platformValidator;
  final IDebugTools _debugTools;
  final ILocalStorageStack _localStorageStack;

  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  final IOthersBootstrapStack _othersBootstrap;

  /// Constructor allows the injection of custom/mock implementations.
  const AppStartUp({
    IPlatformValidator? platformValidator,
    IDebugTools? debugTools,
    ILocalStorageStack? localStorageStack,
    ILocalizationStack? localizationStack,
    IFirebaseStack? firebaseStack,
    IOthersBootstrapStack? othersBootstrap,
  }) : _platformValidator =
           platformValidator ?? const PlatformValidationStack(),
       _debugTools = debugTools ?? const DebugTools(),
       _localStorageStack = localStorageStack ?? const LocalStorageStack(),
       _localizationStack = localizationStack ?? const LocalizationStack(),
       _firebaseStack = firebaseStack ?? const FirebaseStack(),
       _othersBootstrap = othersBootstrap ?? const OthersBootstrapStack();
  ////
  ////

  /// 🚀 Pre-initialization phase: Flutter bindings + debug tools
  @override
  Future<void> run() async {
    ///
    // Ensures Flutter bindings are ready before any further setup.
    WidgetsFlutterBinding.ensureInitialized();
    //
    // Validates platform (min. OS versions, emulator restrictions, etc).
    await _platformValidator.validatePlatformSupport();
    //
    // Configures Flutter debug tools/overlays.
    _debugTools.configure();
    // ... (other debug tools)
  }

  ////

  /// ✅ This runs before any async operations to show [AppLoader] (splash screen) immediately
  @override
  Future<void> showAppInitLoader() async {
    ///
    // Setup HydratedBloc storage
    await _localStorageStack.initHydratedStorage();
    //
    /// 📦  Register only minimal dependencies (currently, [AppThemeCubit]), that required for [AppLoader].
    await DIContainer.initMinimal();
    //
    /// Try to load theme from storage or fallback to system theme.
    final theme = await ThemeForInitialLoader.get();
    //
    // Show minimal app shell with loader while app initializes
    runApp(InitAppLoaderShell(initialTheme: theme));
    debugPrint('🚀 Init App Loader completed');
  }

  ////

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> bootstrap() async {
    // 📦 Initializes app dependencies via GetIt (DI container)
    await DIContainer.initFull();
    //
    await _localizationStack.init();
    //
    await _firebaseStack.init();
    //
    _othersBootstrap.initUrlStrategy();
  }

  //
}
