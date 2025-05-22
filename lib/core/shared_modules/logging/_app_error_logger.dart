import 'package:flutter/foundation.dart' show debugPrint;
import '../../app_config/bootstrap/di_container.dart' show di;
import '../errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '../overlays/overlay_entries/_overlay_entries.dart';
import 'i_logger_contract.dart';

/// 🧭 [AppLogger] — Centralized logger for all application-level telemetry.
/// 🔍 Supports:
/// - Runtime exceptions
/// - Domain-level failures
/// - Bloc errors
/// - Overlay lifecycle
/// - Localization fallbacks
///-----------------------------------------------------------------------------
abstract final class AppLogger {
  const AppLogger._();

  static final ILogger _logger = di<ILogger>();

  // ───────────────────────────────────── Overlay ─────────────────────────────────────

  /// 🪧 Logs when overlay is enqueued (before any processing).
  static void logOverlayShow(OverlayUIEntry request) {
    final type = request.runtimeType.toString();
    final strategy = request.strategy;
    debugPrint(
      '[Overlay][$type] Show → '
      'priority: ${strategy.priority.name}, '
      'category: ${strategy.category.name}, '
      'policy: ${strategy.policy.name}, '
      'tapThrough: ${request.tapPassthroughEnabled}',
    );
  }

  /// ✅ Logs when overlay is inserted into the overlay stack.
  static void logOverlayInserted(OverlayUIEntry? request) {
    final type = request?.runtimeType.toString() ?? 'Unknown';
    final strategy = request?.strategy;
    debugPrint(
      '[Overlay][$type] Inserted → '
      'priority: ${strategy?.priority.name ?? 'n/a'}, '
      'category: ${strategy?.category.name ?? 'n/a'}, '
      'policy: ${strategy?.policy.name ?? 'n/a'}',
    );
  }

  /// ❌ Logs when overlay is dismissed and removed.
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

  /// 🪧 Logs for dispatcher events
  static void logOverlayActiveExists(OverlayUIEntry? request) {
    debugPrint('[🟠 Active exists → ${request.runtimeType}]');
  }

  static void logOverlayDroppedSameType() {
    debugPrint('[🚫 Dropped: dropIfSameType]');
  }

  static void logOverlayReplacing() {
    debugPrint('[♻️ Replacing current]');
  }

  static void logOverlayAddedToQueue(int length) {
    debugPrint('[➕ Added to queue] length = $length');
  }

  /// ⚠️ Logs when dismiss animation fails unexpectedly.
  static void logOverlayDismissAnimationError(OverlayUIEntry? request) {
    final type = request?.runtimeType.toString() ?? 'Unknown';
    debugPrint('[Overlay][$type] ❌ Failed to reverse dismiss animation.');
  }

  /// ⏳ Logs when overlay auto-dismisses after timeout or animation reverse.
  static void logOverlayAutoDismiss(OverlayUIEntry? request) {
    final type = request?.runtimeType.toString() ?? 'Unknown';
    final strategy = request?.strategy;
    debugPrint(
      '[Overlay][$type] ⏳ AutoDismissed → '
      'priority: ${strategy?.priority.name ?? 'n/a'}, '
      'category: ${strategy?.category.name ?? 'n/a'}, '
      'policy: ${strategy?.policy.name ?? 'n/a'}',
    );
  }

  // ───────────────────────────────────── Failures ─────────────────────────────────────

  /// ❗ Logs uncaught SDK/API exceptions before mapping.
  static void logException(Object error, [StackTrace? stackTrace]) =>
      _logger.logException(error, stackTrace);

  /// 🧱 Logs a [Failure] after it has been mapped in domain.
  static void logFailure(Failure failure, [StackTrace? stackTrace]) =>
      _logger.logFailure(failure, stackTrace);

  // ───────────────────────────────────── Bloc ─────────────────────────────────────

  /// 🧨 Logs errors originating from Bloc observers.
  static void logBlocError({
    required Object error,
    required StackTrace stackTrace,
    required String origin,
  }) => _logger.logBlocError(
    error: error,
    stackTrace: stackTrace,
    origin: origin,
  );

  // ───────────────────────────────────── Localization ─────────────────────────────────────

  /// 🌐 Logs when a translation key is missing and fallback is used.
  // static void logMissingTranslation(ITranslationKey key) {
  //   debugPrint(
  //     '[Localization] Missing → "${key.translationKey}". Fallback used: "${key.fallback}"',
  //   );
  // }

  /// 🌐 Logs when `.tl()` is called and string fallback is returned.
  static void logStringFallback(String key, String fallback) {
    debugPrint('[Localization] String fallback for "$key" → "$fallback"');
  }

  ///
}
