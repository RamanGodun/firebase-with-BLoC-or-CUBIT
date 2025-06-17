import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'core/modules_shared/di_container/di_container.dart';
import 'core/modules_shared/localization/app_localizer.dart';
import 'core/app_configs/firebase/env.dart';
import 'core/modules_shared/logging/bloc_observer.dart';

///🚀✅ Handles startup initialization: env, Firebase, BLoC, HydratedStorage, localization
// ✅ Loads `.env`, sets up Firebase, HydratedBloc, and EasyLocalization

final class StartUpHandler {
  ///──────────────────────
  StartUpHandler._();

  ///

  ///🎯 Entry point — must be called before `runApp()`
  // ✅ Sequentially initializes all core servic

  static Future<void> bootstrap() async {
    ///─────────────────────────────────
    //
    _initializeCoreBindings();

    await _initLocalization();

    await _initEnvFile();
    await _initFirebase();
    await _initHydratedStorage();

    // 📦 Initializes app dependencies via GetIt
    await AppDI.init();
  }

  ///

  ///🛠️ Initializes fundamental Flutter bindings and core services
  // ✅ Sets up global Riverpod DI container with overrides

  static void _initializeCoreBindings() {
    /// ─────────────────────────────────
    //
    WidgetsFlutterBinding.ensureInitialized();
    //👁️ Registers Bloc observer for global event tracking
    Bloc.observer = const AppBlocObserver();
    // 🌈 Enables debug painting for layout visualization (repaint regions)
    debugRepaintRainbowEnabled = false;
  }

  ///

  ///🌍 Initializes localization engine (EasyLocalization)
  // ✅ Sets up `AppLocalizer` resolver

  static Future<void> _initLocalization() async {
    ///────────────────────────────────────────────
    //
    await EasyLocalization.ensureInitialized();
    // ? when app with localization, use this:
    AppLocalizer.init(resolver: (key) => key.tr());
    // ! when app without localization, then instead previous method use next:
    // AppLocalizer.initWithFallback();
  }
}

///

///📄 Loads environment variables from `.env.{env}`
// ✅ Detects current environment: dev, staging, prod
// ✅ Loads the correct `.env` config file

Future<void> _initEnvFile() async {
  ///────────────────────────────────────
  //
  final envFile = switch (EnvConfig.currentEnv) {
    Environment.dev => '.env.dev',
    Environment.staging => '.env.staging',
    Environment.prod => '.env',
  };
  await dotenv.load(fileName: envFile);
  debugPrint('✅ Loaded env: $envFile');
}

///

///🔥 Initializes Firebase SDK
// ✅ Sets up Firebase for analytics, auth, Firestore, etc.

Future<void> _initFirebase() async {
  ///──────────────────────────────
  //
  await Firebase.initializeApp();
}

///

///💾 Configures HydratedBloc persistent storage

Future<void> _initHydratedStorage() async {
  ///────────────────────────────────────-
  //
  final storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(
              (await getApplicationDocumentsDirectory()).path,
            ),
  );
  HydratedBloc.storage = storage;
}
