/// 🌐 [EnvConfig] — Environment-based configuration
/// Supports `dev`, `staging`, and `prod` modes, use `.env` + `flutter_dotenv` for actual secrets.

/// ! 🔐 Never store real credentials here!
/// This file enables:
///       • Per-env API URLs
///       • Feature toggles
///       • Logging / debug switches
///       • Static defaults in development

library;

enum Environment { dev, staging, prod }

final class EnvConfig {
  /// 🌍 Current environment (⚠️ change before release!)
  static const Environment currentEnv = Environment.dev;

  /// 🌐 Base API endpoint
  static String get apiBaseUrl => switch (currentEnv) {
    Environment.dev => 'https://api-dev.example.com',
    Environment.staging => 'https://api-staging.example.com',
    Environment.prod => 'https://api.example.com',
  };

  /// 🔥 Firebase key (fallback mock only — real one via dotenv)
  static String get firebaseApiKey => switch (currentEnv) {
    Environment.dev => 'DEV_FIREBASE_KEY',
    Environment.staging => 'STAGING_FIREBASE_KEY',
    Environment.prod => 'PROD_FIREBASE_KEY',
  };

  /// 🐞 Toggle for debug tools and verbose logging
  static bool get isDebugMode => currentEnv == Environment.dev;

  /// 🚀 Toggle for staging QA tools
  static bool get isStagingMode => currentEnv == Environment.staging;

  /// 🔒 Production mode check
  static bool get isProduction => currentEnv == Environment.prod;

  ///
}
