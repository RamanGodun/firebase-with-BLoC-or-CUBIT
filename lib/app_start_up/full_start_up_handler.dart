/*


import 'package:firebase_with_bloc_or_cubit/app_start_up/app_core_initializations/firebase.dart'
    show IFirebaseStack, FirebaseStack;
import 'package:firebase_with_bloc_or_cubit/app_start_up/app_core_initializations/localization.dart'
    show ILocalizationStack, LocalizationStack;
import 'package:firebase_with_bloc_or_cubit/app_start_up/app_core_initializations/others.dart'
    show IOthersBootstrapStack, OthersBootstrapStack;
import 'package:flutter/material.dart';

import 'di_container/di_container.dart';

/// 🧰 [StartUpHandler] — Abstract contract for app startup logic

sealed class IAppFullStartUpHandler {
  ///----------------------------------
  const IAppFullStartUpHandler();
  //
  /// 🚀 Main initialization: all services and dependencies
  Future<void> run();
  //
}

////

////

/// 🧰 [AppFullStartUpHandler] — Production [StartUpHandler] implementation for bootstrapping all critical services.
/// ✅ All dependencies are injectable for testing/mocking.

final class AppFullStartUpHandler extends IAppFullStartUpHandler {
  /// ────────────────────-----------------------------
  //
  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  // final ILocalStorageStack _localStorageStack;
  final IOthersBootstrapStack _othersBootstrap;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are optional and will default to production implementations.
  const AppFullStartUpHandler({
    ILocalizationStack? localizationStack,
    IFirebaseStack? firebaseStack,
    // ILocalStorageStack? localStorageStack,
    IOthersBootstrapStack? othersBootstrap,
  }) : _localizationStack = localizationStack ?? const LocalizationStack(),
       _firebaseStack = firebaseStack ?? const FirebaseStack(),
       //  _localStorageStack =
       //  localStorageStack ?? const DefaultLocalStorageStack(),
       _othersBootstrap = othersBootstrap ?? const OthersBootstrapStack();

  ////

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> run() async {
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




 */
