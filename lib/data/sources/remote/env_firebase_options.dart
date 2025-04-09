/// 📦 Firebase configuration based on current environment (.env + flutter_dotenv)
/// Uses `flutter_dotenv` to securely read values from .env files

library;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 🧩 [EnvFirebaseOptions] - Platform-based Firebase configuration
/// Reads env variables using `flutter_dotenv`
///      - android → _android
///      - ios → _ios
///      - web → _web

final class EnvFirebaseOptions {
  /// 🔀 Returns the correct [FirebaseOptions] for the current platform
  static FirebaseOptions get currentPlatform {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => _android,
      TargetPlatform.iOS => _ios,
      TargetPlatform.macOS => throw UnsupportedError('No macOS config'),
      TargetPlatform.windows => throw UnsupportedError('No Windows config'),
      TargetPlatform.linux => throw UnsupportedError('No Linux config'),
      _ when kIsWeb => _web,
      _ => throw UnsupportedError('Unsupported platform'),
    };
  }

  /// 🟢 Android configuration (from .env)
  static FirebaseOptions get _android => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
  );

  /// 🍎 iOS configuration (from .env)
  static FirebaseOptions get _ios => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    iosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID'],
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
  );

  /// 🌐 Web configuration (from .env)
  static FirebaseOptions get _web => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
  );
}
