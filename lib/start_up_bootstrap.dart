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

/// 🧰 [StartUpHandler] — Abstract contract for app startup logic

abstract interface class IStartUpHandler {
  ///----------------------------------
  const IStartUpHandler();
  //
  Future<void> bootstrap();
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

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> bootstrap() async {
    //
    _debugTools.configure();

    await _localStorageStack.init();

    await _localizationStack.init();

    await _firebaseStack.init();

    _othersBootstrap.initUrlStrategy();

    //
  }

  //
}
