import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'custom_error.dart';

/// 🔥 [Failure] — Abstract base class for domain-level failures.
/// 📦 Used in [Either<Failure, T>] to handle errors safely across app layers.
abstract class Failure extends Equatable {
  /// Descriptive error message.
  final String message;

  /// Optional code to identify error origin (HTTP code, plugin, etc).
  final dynamic statusCode;

  /// Optional app-specific error code.
  final String? code;

  const Failure({required this.message, this.statusCode, this.code});

  @override
  List<Object?> get props => [message, statusCode, code];
}

///---------------------------------------------------------------------------

/// 🌐 [ApiFailure] — HTTP or GraphQL-related errors.
class ApiFailure extends Failure {
  const ApiFailure({required int super.statusCode, required super.message})
    : super(code: 'API');
}

/// ⚙️ [GenericFailure] — SDK/platform errors, wrapped in [CustomError].
class GenericFailure extends Failure {
  final CustomError error;

  GenericFailure({required this.error})
    : super(
        message: error.message,
        code: error.code,
        statusCode: error.plugin.code,
      );

  @override
  List<Object?> get props => [message, code, statusCode, error];
}

/// ❓ [UnknownFailure] — Fallback for unclassified or unexpected errors.
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.statusCode = 'UNKNOWN'});
}

/// 🔥 [FirebaseFailure] — Firebase-related error wrapper.
class FirebaseFailure extends Failure {
  FirebaseFailure({required super.message, super.code = 'FIREBASE'})
    : super(statusCode: ErrorPlugin.firebase.code);
}

/// 🧠 [UseCaseFailure] — Errors occurring within domain use-cases.
class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message, super.code = 'USE_CASE'})
    : super(statusCode: ErrorPlugin.useCase.code);
}

/// 🪵 [logFailureToCrashlytics] — Logs a [Failure] to Crashlytics or console.
/// Replace with `FirebaseCrashlytics.instance.recordError(...)` in production.
void logFailureToCrashlytics(Failure failure) {
  final source = pluginSource(failure);
  final code = failure.code ?? 'NO_CODE';
  final message = failure.message;
  final type = failure.runtimeType.toString();

  debugPrint('[FAILURE] [$source][$code][$type] $message');
}

/// 🔌 [pluginSource] — Extracts origin source of failure for diagnostics/logging.
String pluginSource(Failure failure) => switch (failure) {
  GenericFailure(:final error) => error.plugin.code,
  ApiFailure() => ErrorPlugin.httpClient.code,
  FirebaseFailure() => ErrorPlugin.firebase.code,
  UseCaseFailure() => ErrorPlugin.useCase.code,
  _ => ErrorPlugin.unknown.code,
};
