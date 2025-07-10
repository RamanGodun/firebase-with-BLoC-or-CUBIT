import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;

/// 🧪 [IDebugTools] — abstraction for debug tools.

abstract interface class IDebugTools {
  ///------------------------------
  //
  /// Configures Flutter-specific debug flags (visual debugging, etc).
  void configure();

  /// Setups global logging or crash reporting (e.g., Crashlytics, Sentry, custom logger).
  void setupLogging();

  /*
    Use [configure] for Flutter-specific debug flags.
    Use [setupLogging] to integrate Crashlytics/Sentry/Logger at app startup.
    All methods can be easily stubbed/mocked in tests.
    For example: setupCrashlytics(), setupLogger(), etc.
  */
}

////

////

/// 🧪 [DebugTools] — production implementation.

final class DebugTools implements IDebugTools {
  ///----------------------------------------------
  const DebugTools();
  //

  /// Configures Flutter-specific debug tools.
  @override
  void configure() {
    // Controls visual debugging options (e.g., repaint highlighting).
    debugRepaintRainbowEnabled = false;
  }

  ///
  @override
  void setupLogging() {
    // debugPrint('Debug logging enabled');
    // або Crashlytics/Sentry setup тут (залишити пустим, якщо не потрібно)
  }

  //
}
