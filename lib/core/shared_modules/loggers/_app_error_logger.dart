import 'package:flutter/foundation.dart' show debugPrint;

import '../../app_config/bootstrap/di_container.dart' show di;
import '../errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '../overlay/presentation/overlay_entries/_overlay_entries.dart';
import '../localization/keys/translation_key_interface.dart';
import 'i_logger_contract.dart';

/// 🧭 [AppErrorLogger] — Centralized logger for all application-level errors.
/// ✅ Unified entry point for logging:
/// - Raw [Exception]/[Error] from SDK/API (before mapping)
/// - Domain-level [Failure] after mapping
/// - Bloc-related errors from [BlocObserver]
/// - Localization-related fallbacks or missing translations
///-----------------------------------------------------------------------------

abstract final class AppErrorLogger {
  const AppErrorLogger._();

  /// 🧠 Cached instance of [ILogger] for performance optimization.
  static final ILogger _logger = di<ILogger>();

  /// ❗ Logs any raw [Exception] or [Error] before mapping to [Failure].
  static void logException(Object error, [StackTrace? stackTrace]) =>
      _logger.logException(error, stackTrace);

  /// 🔁 Logs a domain-level [Failure] after it has been mapped.
  static void logFailure(Failure failure, [StackTrace? stackTrace]) =>
      _logger.logFailure(failure, stackTrace);

  /// 🧨 Logs errors originating from the BLoC system.
  static void logBlocError({
    required Object error,
    required StackTrace stackTrace,
    required String origin,
  }) => _logger.logBlocError(
    error: error,
    stackTrace: stackTrace,
    origin: origin,
  );

  /// 🪧 Logs when overlay is shown.
  static void logOverlayShow(OverlayUIEntry request) {
    final type = request.runtimeType.toString();
    final strategy = request.strategy;
    debugPrint(
      '[Overlay][$type] Show → '
      'duration: ${request.duration.inMilliseconds}ms, '
      'priority: ${strategy.priority.name}, '
      'category: ${strategy.category.name}, '
      'policy: ${strategy.policy.name}, '
      'tapThrough: ${request.tapPassthroughEnabled}',
    );
  }

  /// ❌ Logs when overlay is dismissed.
  static void logOverlayDismiss(OverlayUIEntry? request) {
    final type = request?.runtimeType.toString() ?? 'Unknown';
    final strategy = request?.strategy;
    debugPrint(
      '[Overlay][$type] Dismissed → '
      'priority: ${strategy?.priority.name ?? 'n/a'}, '
      'category: ${strategy?.category.name ?? 'n/a'}, '
      'policy: ${strategy?.policy.name ?? 'n/a'}',
    );
  }

  /// 🌐 Logs when translation fallback is used.
  static void logMissingTranslation(ITranslationKey key) {
    debugPrint(
      '[Localization] Missing → "${key.translationKey}". Fallback used: "${key.fallback}"',
    );
  }

  /// 🌐 Logs dynamic `.tl()` string fallback (when fallback is returned as-is)
  static void logStringFallback(String key, String fallback) {
    debugPrint('[Localization] String fallback for "$key" → "$fallback"');
  }
}
