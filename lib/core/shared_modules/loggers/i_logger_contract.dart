import '../errors_handling/failures/failure.dart';

/// 📄 [ILogger] — Interface for application-wide error logging.
/// ✅ Enables switching between different logger implementations (e.g., Crashlytics, Console, Mock).
/// ✅ Promotes testability and adherence to SOLID principles (DIP).
///-----------------------------------------------------------------------------

abstract interface class ILogger {
  /// ❗ Logs any raw [Exception] or [Error] before mapping to [Failure].
  void logException(Object error, [StackTrace? stackTrace]);

  /// 🔁 Logs a domain-level [Failure] after it has been mapped.
  void logFailure(Failure failure, [StackTrace? stackTrace]);

  /// 🧨 Logs errors originating from the BLoC system.
  void logBlocError({
    required Object error,
    required StackTrace stackTrace,
    required String origin,
  });

  //
}
