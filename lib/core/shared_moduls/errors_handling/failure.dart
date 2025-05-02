import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'custom_error.dart';

/// 🧩 [Failure] — abstract domain error model
/// 🧼 Represents all possible error states in domain layer
//----------------------------------------------------------------//
abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;
  final String? code;

  const Failure({required this.message, this.statusCode, this.code});

  @override
  List<Object?> get props => [message, statusCode, code];
}

/// 🧩 [ApiFailure] — for REST or GraphQL errors
class ApiFailure extends Failure {
  const ApiFailure({required int super.statusCode, required super.message})
    : super(code: 'API');
}

/// 🧩 [GenericFailure] — for platform, SDK, or unknown errors
class GenericFailure extends Failure {
  final CustomError error;

  GenericFailure({required this.error})
    : super(
        message: error.message,
        code: error.code,
        statusCode: error.plugin.code,
      );

  @override
  @override
  List<Object?> get props => [message, code, statusCode, error];
}

/// 🧩 [UnknownFailure] — fallback for anything unmatched
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.statusCode = 'UNKNOWN'});
}

/// 🧩 [FirebaseFailure] — Firebase-specific errors
class FirebaseFailure extends Failure {
  FirebaseFailure({required super.message, super.code = 'FIREBASE'})
    : super(statusCode: ErrorPlugin.firebase.code);
}

/// 🧩 [UseCaseFailure] — use-case level domain errors
class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message, super.code = 'USE_CASE'})
    : super(statusCode: ErrorPlugin.useCase.code);
}

/// 🧪 [logFailureToCrashlytics] — logs detailed error into Crashlytics or console
void logFailureToCrashlytics(Failure failure) {
  final source = pluginSource(failure);
  final code = failure.code ?? 'NO_CODE';
  final message = failure.message;
  final type = failure.runtimeType.toString();

  // Replace this with FirebaseCrashlytics.instance.recordError(...) if available
  debugPrint('[FAILURE] [$source][$code][$type] $message');
}

String pluginSource(Failure failure) => switch (failure) {
  GenericFailure(:final error) => error.plugin.code,
  ApiFailure() => ErrorPlugin.httpClient.code,
  FirebaseFailure() => ErrorPlugin.firebase.code,
  UseCaseFailure() => ErrorPlugin.useCase.code,
  _ => ErrorPlugin.unknown.code,
};
