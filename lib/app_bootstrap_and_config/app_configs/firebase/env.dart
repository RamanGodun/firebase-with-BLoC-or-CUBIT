library;

/// 🌐 [EnvConfig] — Environment-based configuration
/// Supports dev, staging, and prod modes via `flutter_dotenv`.
/// Never store secrets directly here.
/// Used for: API base URLs, Feature toggles, Logging flags

final class EnvConfig {
  ///-----------------
  EnvConfig._();
  //

  /// 🌍 Current environment (⚠️ adjust before release!)
  static const Environment currentEnv = Environment.dev;

  /// 🌐 API base URL by environment
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

  /// 🔐 Indicates if app is running in production
  static bool get isProduction => currentEnv == Environment.prod;

  //
}

////

enum Environment { dev, staging, prod }

////

extension EnvFileName on Environment {
  String get fileName => switch (this) {
    Environment.dev => '.env.dev',
    Environment.staging => '.env.staging',
    Environment.prod => '.env',
  };
}
