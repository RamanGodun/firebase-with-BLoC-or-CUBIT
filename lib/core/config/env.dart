/*

!env.dart – Конфігурація середовищ (env) **

Важливо мати окремі конфігурації для production, staging, development.
Тут визначаються API-ключі, базові URL, тощо.

!!! ⚠️ ВАЖЛИВО! Не зберігай реальні ключі в коді! Для цього використовують .env файли + flutter_dotenv.
 */

enum Environment { dev, staging, prod }

class EnvConfig {
  static const Environment currentEnv = Environment.dev;

  static String get apiBaseUrl {
    switch (currentEnv) {
      case Environment.dev:
        return "https://api-dev.example.com";
      case Environment.staging:
        return "https://api-staging.example.com";
      case Environment.prod:
        return "https://api.example.com";
    }
  }

  static String get firebaseApiKey {
    switch (currentEnv) {
      case Environment.dev:
        return "DEV_FIREBASE_KEY";
      case Environment.staging:
        return "STAGING_FIREBASE_KEY";
      case Environment.prod:
        return "PROD_FIREBASE_KEY";
    }
  }
}
