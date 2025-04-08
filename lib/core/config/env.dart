/*
 🔐 Environment Configuration File — `env.dart`

 This file defines the available environments: `dev`, `staging`, `prod`.

 🔧 Do NOT hardcode sensitive API keys here!
 ➜ Use `.env` files + `flutter_dotenv` for real credentials.

 This setup allows environment-based configuration for:
   • API endpoints
   • Firebase keys (via secure .env)
   • Logging toggles, debug tools, etc.
*/

enum Environment { dev, staging, prod }

class EnvConfig {
  /// 🌍 Current environment mode — switch before release
  static const Environment currentEnv = Environment.dev;

  /// 🌐 Base URL for API
  static String get apiBaseUrl => switch (currentEnv) {
    Environment.dev => 'https://api-dev.example.com',
    Environment.staging => 'https://api-staging.example.com',
    Environment.prod => 'https://api.example.com',
  };

  /// 🔥 Firebase API Key — use `flutter_dotenv` for actual secret values
  static String get firebaseApiKey => switch (currentEnv) {
    Environment.dev => 'DEV_FIREBASE_KEY',
    Environment.staging => 'STAGING_FIREBASE_KEY',
    Environment.prod => 'PROD_FIREBASE_KEY',
  };

  /// 🐞 Enables detailed logging for development
  static bool get isDebugMode => currentEnv == Environment.dev;
}
