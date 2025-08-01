import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/app_bootstrap/local_storage_init.dart'
    show ILocalStorage, HydratedLocalStorage;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;
import '../../core/base_modules/localization/core_of_module/init_localization.dart';
import '../../core/base_modules/logging/for_bloc/bloc_observer.dart';
import 'remote_db_init.dart';
import 'platform_validation.dart';
import '../di_container/di_container_init.dart';

part 'bootstrap_interface.dart';

/// 🧰 [AppBootstrap] — Handles all critical bootstrapping (with injectable stacks for testing/mocks).
//
final class AppBootstrap implements IAppBootstrap {
  ///-------------------------------------------
  //
  final ILocalStorage _localStorage;
  final IRemoteDataBase _remoteDataBase;

  /// Constructor allows the injection of custom/mock implementations.
  const AppBootstrap({
    ILocalStorage? localStorageStack,
    IRemoteDataBase? firebaseStack,
  }) : _localStorage = localStorageStack ?? const HydratedLocalStorage(),
       _remoteDataBase = firebaseStack ?? const FirebaseRemoteDataBase();

  ////
  ////

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> initAllServices() async {
    //
    debugPrint('🚀 [Bootstrap] Starting full initialization...');
    await appStartUp();
    //
    await initGlobalDIContainer(); // 📦  Register dependencies via GetIt
    //
    /// Ensures EasyLocalization is initialized before runApp.
    await initEasyLocalization();
    //
    /// Initializes local storage (currently, GetStorage).
    await initLocalStorage();
    //
    /// Initializes remote database (currently, Firebase).
    await initRemoteDataBase();
    //
    setPathUrlStrategy();
    debugPrint('✅ [Bootstrap] All services initialized!');
    //
  }

  ////

  @override
  Future<void> appStartUp() async {
    //
    debugPrint('🟢 [Startup] Flutter bindings and platform checks...');
    // Ensures Flutter bindings are ready before any further setup.
    WidgetsFlutterBinding.ensureInitialized();
    //
    /// Validates platform (min. OS versions, emulator restrictions, etc).
    await PlatformValidationUtil.run();
    //
    /// Controls visual debugging options (e.g., repaint highlighting).
    debugRepaintRainbowEnabled = false;
    //
    /// Custom bloc observer
    Bloc.observer = const AppBlocObserver();
    //
    /// ... (other debug tools)
    debugPrint('✅ [Startup] Flutter bindings and platform validation done.');
    //
  }

  ////

  @override
  Future<void> initGlobalDIContainer() async {
    //
    debugPrint('📦 [DI] Initializing global dependency container...');
    // 📦  Register dependencies via GetIt
    await DIContainer.initFull();
    debugPrint('✅ [DI] Dependency container ready.');
  }

  ////

  @override
  Future<void> initLocalStorage() async {
    //
    debugPrint('💾 [Storage] Initializing local storage...');
    // Setup HydratedBloc storage currently
    await _localStorage.init();
    debugPrint('✅ [Storage] Local storage initialized.');
  }

  ////

  @override
  Future<void> initRemoteDataBase() async {
    //
    debugPrint('🗄️ [RemoteDB] Initializing remote database...');
    // Initializes remote database (currently, Firebase).
    await _remoteDataBase.init();
    debugPrint('✅ [RemoteDB] Remote database initialized.');
  }

  ////

  Future<void> initEasyLocalization() async {
    //
    debugPrint('🌍 Initializing EasyLocalization...');
    await EasyLocalization.ensureInitialized();
    //
    /// 🌍 Sets up the global localization resolver for the app.
    AppLocalizer.init(resolver: (key) => key.tr());
    // ? when app without localization, then instead previous method use next:
    // AppLocalizer.initWithFallback();
    debugPrint('✅ EasyLocalization initialized!');
    //
  }

  //
}
