/// ⚙️ [AppConfig] — Global application constants.
/// Centralizes:
///   • App identity & version
///   • Platform requirements
///   • Build flags (debug, CI)
///   • Global network configs

library;

final class AppConfig {
  /// 🏷️ App display name
  static const String appName = 'Firebase with BLoC/Cubit';

  /// 🪪 App version (keep in sync with pubspec.yaml)
  static const String version = '0.1.0';

  /// 📱 Minimum Android SDK supported
  static const int minSdkVersion = 23;

  /// ⏱️ Default timeout for network requests
  static const Duration requestTimeout = Duration(seconds: 10);

  /// 🚀 Indicates if build is in release mode
  static const bool isReleaseMode = bool.fromEnvironment('dart.vm.product');

  /// 🐞 Indicates if running in debug mode
  static bool get isDebugMode => !isReleaseMode;

  /// 🧪 Indicates if running in CI pipeline
  static const bool isCI = bool.fromEnvironment('CI');
}
