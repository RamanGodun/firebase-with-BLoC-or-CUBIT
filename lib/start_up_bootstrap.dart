import 'package:firebase_with_bloc_or_cubit/debug_tools_init.dart'
    show IDebugTools, DefaultDebugTools;
import 'package:firebase_with_bloc_or_cubit/firebase_init.dart'
    show IFirebaseStack, DefaultFirebaseStack;
import 'package:firebase_with_bloc_or_cubit/local_storage_init.dart'
    show ILocalStorageStack, DefaultLocalStorageStack;
import 'package:firebase_with_bloc_or_cubit/localization_init.dart'
    show ILocalizationStack, DefaultLocalizationStack;
import 'package:firebase_with_bloc_or_cubit/others_boostrap.dart'
    show IOthersBootstrap, DefaultOthersBootstrap;
import 'package:flutter/material.dart';
import 'core/layers_shared/presentation_layer_shared/widgets_shared/loaders/get_theme_for_initial_loader.dart';
import 'core/layers_shared/presentation_layer_shared/widgets_shared/loaders/material_app_for_loader.dart';
import 'core/modules_shared/di_container/di_container.dart';

/// 🧰 [StartUpHandler] — Abstract contract for app startup logic

abstract interface class IStartUpHandler {
  ///----------------------------------
  const IStartUpHandler();
  //
  /// Initializes Flutter bindings and debug tools
  Future<void> preBootstrap();
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

/// 🧰 [DefaultStartUpHandler] — Handles all critical bootstrapping (with injectable stacks for testing/mocks).

final class DefaultStartUpHandler implements IStartUpHandler {
  ///-------------------------------------------------------
  //
  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  final ILocalStorageStack _localStorageStack;
  final IDebugTools _debugTools;
  final IOthersBootstrap _othersBootstrap;

  /// Constructor allows the injection of custom/mock implementations.
  const DefaultStartUpHandler({
    ILocalizationStack? localizationStack,
    IFirebaseStack? firebaseStack,
    ILocalStorageStack? localStorageStack,
    IDebugTools? debugTools,
    IOthersBootstrap? othersBootstrap,
  }) : _localizationStack =
           localizationStack ?? const DefaultLocalizationStack(),
       _firebaseStack = firebaseStack ?? const DefaultFirebaseStack(),
       _localStorageStack =
           localStorageStack ?? const DefaultLocalStorageStack(),
       _debugTools = debugTools ?? const DefaultDebugTools(),
       _othersBootstrap = othersBootstrap ?? const DefaultOthersBootstrap();
  ////
  ////

  /// 🚀 Pre-initialization phase: Flutter bindings + debug tools
  @override
  Future<void> preBootstrap() async {
    ///
    // Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();
    //
    // Setup and validate debug tools/platform.
    _debugTools.configure();
    await _debugTools.validatePlatformSupport();
    // ... (other debug tools)
  }

  ////

  /// ✅ This runs before any async operations to show [AppLoader] (splash screen) immediately
  @override
  Future<void> showAppInitLoader() async {
    ///
    // Setup HydratedBloc storage (critical for persistent state).
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
    //
    /// 📦 Initializes app dependencies via GetIt (DI container)
    await DIContainer.initFull();
    //
    await _localizationStack.init();
    //
    await _firebaseStack.init();
    //
    _othersBootstrap.initUrlStrategy();
    //
  }

  //
}
