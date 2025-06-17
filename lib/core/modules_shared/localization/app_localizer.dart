import 'when_no_localization/fallback_keys.dart';
import 'localization_logger.dart';

abstract final class AppLocalizer {
  static String Function(String key)? _resolver;

  /// 🌐 Resolves a translation key or returns fallback
  static String t(String key, {String? fallback}) {
    final value = _resolver?.call(key);
    final resolved = (value == null || value == key);
    if (resolved) {
      LocalizationLogger.fallbackUsed(key, fallback ?? key);
      return fallback ?? key;
    }
    return value;
  }

  /// 🧩 Initializes the resolver (once)
  static void init({required String Function(String key) resolver}) {
    if (_resolver != null) return; // ⛔ prevent double initialization
    _resolver = resolver;
  }

  /// ✅ Use this instead of [AppLocalizer.init] when EasyLocalization is not available
  /// 🔁 All missing keys will fall back to [LocalesFallbackMapper]
  static void initWithFallback() {
    AppLocalizer.init(
      resolver: (key) => LocalesFallbackMapper.resolveFallback(key),
    );
  }

  /// 🔁 Forcefully overrides the resolver (used in testing or switching at runtime)
  static void forceInit({required String Function(String key) resolver}) {
    _resolver = resolver;
  }

  /// 🧪 Internal check (used in debug/tests)
  static bool get isInitialized => _resolver != null;

  ///
}
