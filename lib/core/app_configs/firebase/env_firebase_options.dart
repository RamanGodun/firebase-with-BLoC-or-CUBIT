import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 📦 [EnvFirebaseOptions] — Platform-aware Firebase config via .env variables
/// ✅ Uses `flutter_dotenv` to inject Firebase credentials at runtime
/// 🔐 Reads secrets securely from environment-specific .env files

final class EnvFirebaseOptions {
  ///-------------------------
  EnvFirebaseOptions._();
  //

  /// 🧠 Chooses correct [FirebaseOptions] based on platform
  static FirebaseOptions get currentPlatform {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => _android,
      TargetPlatform.iOS => _ios,
      TargetPlatform.macOS => throw UnsupportedError('❌ macOS not supported'),
      TargetPlatform.windows =>
        throw UnsupportedError('❌ Windows not supported'),
      TargetPlatform.linux => throw UnsupportedError('❌ Linux not supported'),
      _ when kIsWeb => _web,
      _ => throw UnsupportedError('❌ Unsupported platform'),
    };
  }

  /// 🤖 Android config from .env
  @pragma('vm:prefer-inline')
  static FirebaseOptions get _android => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
  );

  /// 🍏 iOS config from .env
  @pragma('vm:prefer-inline')
  static FirebaseOptions get _ios => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    iosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID'],
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
  );

  /// 🌐 Web config from .env
  @pragma('vm:prefer-inline')
  static FirebaseOptions get _web => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
  );

  //
}
