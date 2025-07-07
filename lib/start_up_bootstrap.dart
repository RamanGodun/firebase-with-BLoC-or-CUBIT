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
  /// 🚀 Pre-initialization: Flutter bindings + splash loader + neccessary DI container
  Future<void> preBootstrap();

  /// 🚀 Main initialization: all services and dependencies
  Future<void> bootstrap();
  //
}

////

////

/// 🧰 [DefaultStartUpHandler] — Production [StartUpHandler] implementation for bootstrapping all critical services.
/// ✅ All dependencies are injectable for testing/mocking.

/// 🧰 [DefaultStartUpHandler] — Default production startup logic with injectable stacks.
final class DefaultStartUpHandler implements IStartUpHandler {
  ///-------------------------------------------------------
  //
  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  final ILocalStorageStack _localStorageStack;
  final IDebugTools _debugTools;
  final IOthersBootstrap _othersBootstrap;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are optional and will default to production implementations.
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

  /// 🚀 Pre-initialization phase: Flutter bindings + splash screen
  /// ✅ This runs before any async operations to show immediate feedback
  @override
  Future<void> preBootstrap() async {
    ///
    // Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();

    _debugTools.configure();
    await _debugTools.validatePlatformSupport();

    await _localStorageStack.initHydratedBloc();

    /// 📦 Initializes minimal necessary app dependencies via GetIt (DI container)
    await DIContainer.initMinimal();

    final theme = await ThemeForInitialLoader.get();
    // Show splash loader while app initializes
    runApp(InitLoaderWrapper(initialTheme: theme));
    debugPrint('🚀 Pre-bootstrap completed: Flutter bindings + splash loader');
  }

  ////

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> bootstrap() async {
    //
    /// 📦 Initializes app dependencies via GetIt (DI container)
    await DIContainer.initFull();

    await _localizationStack.init();

    // await _localStorageStack.initHydratedBloc();

    await _firebaseStack.init();

    _othersBootstrap.initUrlStrategy();

    //
  }

  //
}
