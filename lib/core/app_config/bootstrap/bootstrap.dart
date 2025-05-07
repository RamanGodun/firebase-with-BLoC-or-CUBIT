import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:path_provider/path_provider.dart';

import '../env.dart';
import '../../shared_modules/errors_handling/loggers/app_bloc_observer.dart';

/// 🚀 [AppBootstrap] — Handles platform & app core initialization
/// ✅ Loads environment config, sets up Firebase, Bloc observer, and state persistence
//-----------------------------------------------------------------------------

final class AppBootstrap {
  AppBootstrap._();

  /// 🎯 Entry point — must be called before `runApp`
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initEnv();
    _initBlocObserver();
    await _initFirebase();
    await _initHydratedStorage(); // 💾 HydratedBloc persistence
  }

  /// 📄 Loads `.env.{environment}` config file based on current environment mode
  static Future<void> _initEnv() async {
    final envFile = switch (EnvConfig.currentEnv) {
      Environment.dev => '.env.dev',
      Environment.staging => '.env.staging',
      Environment.prod => '.env',
    };
    await dotenv.load(fileName: envFile);
    debugPrint('✅ Loaded env: $envFile');
  }

  /// 👁️ Attaches a global observer to watch Bloc events and transitions
  static void _initBlocObserver() {
    Bloc.observer = const AppBlocObserver();
  }

  /// 🔥 Initializes Firebase SDK (core only — used by all Firebase services)
  static Future<void> _initFirebase() async {
    await Firebase.initializeApp();
  }

  /// 💾 Configures persistent HydratedBloc (local storage)
  static Future<void> _initHydratedStorage() async {
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

  ///
}

///
/*
! can use next (then delete ❌ GoogleService-Info.plist google-services.json)
await Firebase.initializeApp(options: EnvFirebaseOptions.currentPlatform);

! then, also use this: 
Future<void> safeFirebaseInit() async {
  if (Firebase.apps.isNotEmpty) {
    debugPrint('⚠️ Firebase already initialized');
    return;
  }

   if (kIsWeb) {
    await Firebase.initializeApp(options: EnvFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(); 
  }
  debugPrint('✅ Firebase initialized');
}

 */
