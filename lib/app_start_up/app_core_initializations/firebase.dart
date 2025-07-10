import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/app_configs/firebase/env.dart';
import '../../core/app_configs/firebase/env_firebase_options.dart';
import '../../core/app_configs/firebase/firebase_utils.dart';

/// 🔥 [IFirebaseStack] — abstraction for Firebase + env initialization.
/// ✅ Used to decouple startup logic and enable mocking in tests.

abstract interface class IFirebaseStack {
  ///---------------------------------
  //
  /// Initializes all Firebase services
  Future<void> init();
  //
}

////

////

/// 🔥 [FirebaseStack] — [IFirebaseStack] implementation.

final class FirebaseStack implements IFirebaseStack {
  ///----------------------------------------------------
  const FirebaseStack();

  @override
  Future<void> init() async {
    //
    debugPrint('🔥 FirebaseStack: loading env file...');
    //📀 Loads environment configuration (.env file), based on current environment
    await dotenv.load(fileName: EnvConfig.currentEnv.fileName);
    debugPrint('✅ Loaded env file: ${EnvConfig.currentEnv.fileName}');

    /// 🔥 Initializes Firebase if not already initialized
    if (!FirebaseUtils.isDefaultAppInitialized) {
      try {
        debugPrint('🔥 Initializing Firebase...');
        await Firebase.initializeApp(
          options: EnvFirebaseOptions.currentPlatform,
        );
        debugPrint('🔥 Firebase initialized!');
      } on FirebaseException catch (e) {
        if (e.code == 'duplicate-app') {
          debugPrint('⚠️ Firebase already initialized, skipping...');
        } else {
          rethrow;
        }
      }
    } else {
      debugPrint('⚠️ Firebase already initialized (checked manually)');
    }

    // Log all initialized Firebase apps for debug.
    FirebaseUtils.logAllApps();
    //
  }

  //
}
