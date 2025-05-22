import '../../logging/_app_error_logger.dart';

abstract final class AppLocalizer {
  static String Function(String key)? _resolver;

  /// 🌐 Resolves a translation key or returns fallback
  static String t(String key, {String? fallback}) {
    final value = _resolver?.call(key);
    final resolved = (value == null || value == key);
    if (resolved) {
      AppLogger.logStringFallback(key, fallback ?? key);
      return fallback ?? key;
    }
    return value;
  }

  /// 🧩 Initializes the resolver (once)
  static void init({required String Function(String key) resolver}) {
    if (_resolver != null) return; // ⛔ prevent double initialization
    _resolver = resolver;
  }

  /// 🔁 Forcefully overrides the resolver (used in testing or switching at runtime)
  static void forceInit({required String Function(String key) resolver}) {
    _resolver = resolver;
  }

  /// 🧪 Internal check (used in debug/tests)
  static bool get isInitialized => _resolver != null;

  ///
}
