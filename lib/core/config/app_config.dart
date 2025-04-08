/// 🌐 Global application configuration
///
/// Contains:
/// - App metadata (name, version, SDK constraints)
/// - Default timeouts or global constants
/// - Any other app-wide static config
library;

final class AppConfig {
  /// 🧾 Application name shown in various places
  static const String appName = 'Firebase with BLoC/Cubit';

  /// 🧾 App version (manual sync with pubspec.yaml)
  static const String version = "0.1.0";

  /// 📱 Minimum supported Android SDK version
  static const int minSdkVersion = 24;

  /// ⏱️ Default request timeout for network operations
  static const Duration requestTimeout = Duration(seconds: 10);

  /// 🧪 Whether the app is in debug/testing mode
  static const bool isDebugMode = bool.fromEnvironment('dart.vm.product');

  ///
}
