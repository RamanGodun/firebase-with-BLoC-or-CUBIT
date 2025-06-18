library;

/// ⏱️ Commonly used timeout durations

final class TimeoutConstants {
  ///------------------------
  TimeoutConstants._();

  /// ⏱️ Global timeout for network requests
  static const Duration requestTimeout = Duration(seconds: 10);

  /// ⏳ Timeout for Firebase operations
  static const Duration firebaseTimeout = Duration(seconds: 20);

  /// 💤 Debounce duration for text field validation
  static const Duration debounceDuration = Duration(milliseconds: 350);

  //
}
