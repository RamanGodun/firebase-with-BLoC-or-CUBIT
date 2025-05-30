import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'core/shared_modules/localization/code_base_for_both_options/_app_localizer.dart';
import 'core/app_configs/firebase/env.dart';
import 'core/shared_modules/logging/bloc_observer.dart';

/// 🚀✅ [StartUpHandler] — Handles platform & app core initialization, loads environment config,
/// sets up Firebase, Bloc observer, HydratedBloc persistence, and localization
//-----------------------------------------------------------------------------

final class StartUpHandler {
  StartUpHandler._();

  /// 🎯 Entry point — must be called before `runApp`
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _initBlocObserver();
    await _initEnv();
    await _initFirebase();
    await _initHydratedStorage();
    await _initLocalization();
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

  /// 🌍 Ensures EasyLocalization is initialized before `runApp`
  static Future<void> _initLocalization() async {
    await EasyLocalization.ensureInitialized();
    // ? when app with localization, use this:
    AppLocalizer.init(resolver: (key) => key.tr());
    // ! when app without localization, then instead previous method use next:
    // AppLocalizer.initWithFallback();
  }
}

/// 🔥 Initializes Firebase SDK (core only — used by all Firebase services)
Future<void> _initFirebase() async {
  await Firebase.initializeApp();
}

/// 💾 Configures persistent local storage (HydratedBloc)
Future<void> _initHydratedStorage() async {
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
