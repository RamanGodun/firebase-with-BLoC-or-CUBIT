/// ⚙️ [AppConfig] — Global static configuration for the application.
/// Centralized constants for:
///       - App identity
///       - Versioning
///       - Platform requirements
///       - Global timeouts and flags

library;

final class AppConfig {
  /// 🧾 Application display name
  static const String appName = 'Firebase with BLoC/Cubit';

  /// 🧾 Application version (sync with pubspec.yaml)
  static const String version = '0.1.0';

  /// 📱 Minimum Android SDK version supported
  static const int minSdkVersion = 23;

  /// ⏱️ Global timeout for network requests
  static const Duration requestTimeout = Duration(seconds: 10);

  /// 🧪 Flag for build mode: `true` in **release**, `false` in **debug**
  static const bool isReleaseMode = bool.fromEnvironment('dart.vm.product');

  /// 👀 Flag for easier debug-specific logic
  static bool get isDebugMode => !isReleaseMode;

  ///
  static const bool isCI = bool.fromEnvironment('CI');

  ///
}
