import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

import '../config/env.dart';
import '../config/observer/app_bloc_observer.dart';

/// 🧰 Bootstrap: Loads .env, initializes Firebase, HydratedBloc, BLoC observer.

Future<void> bootstrapApp() async {
  /// 📦 Load .env config file depending on current environment
  final envFile = switch (EnvConfig.currentEnv) {
    Environment.dev => '.env.dev',
    Environment.staging => '.env.staging',
    Environment.prod => '.env',
  };
  await dotenv.load(fileName: envFile);
  debugPrint('✅ Loaded env file: $envFile');

  /// 👁️ Setup global observer for BLoC events/transitions
  Bloc.observer = const AppBlocObserver();

  /// 🔥 Initialize Firebase
  await Firebase.initializeApp();

  /// 💾 Initialize HydratedBloc storage for state persistence
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
