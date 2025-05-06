import 'package:equatable/equatable.dart';
import 'custom_error.dart';

/// 🔥 [Failure] — Abstract base class for domain-level failures.
/// 📦 Used in [Either<Failure, T>] to handle errors safely across app layers.
abstract class Failure extends Equatable {
  /// Descriptive error message.
  final String message;
  // Optional code to identify error origin (HTTP code, plugin, etc).
  final dynamic statusCode;
  // Optional app-specific error code.
  final String? code;

  ///
  const Failure._({required this.message, this.statusCode, this.code});

  ///
  @override
  List<Object?> get props => [message, statusCode, code];

  //
}

///---------------------------------------------------------------------------

/// 🌐 [ApiFailure] — HTTP or GraphQL-related errors.
final class ApiFailure extends Failure {
  const ApiFailure({required int super.statusCode, required super.message})
    : super._(code: 'API');
}

/// ⚙️ [GenericFailure] — SDK/platform errors, wrapped in [CustomError].
final class GenericFailure extends Failure {
  final CustomError error;

  GenericFailure({required this.error})
    : super._(
        message: error.message,
        code: error.code,
        statusCode: error.plugin.code,
      );

  @override
  List<Object?> get props => [message, code, statusCode, error];
}

/// 🔥 [FirebaseFailure] — Firebase-related error wrapper.
final class FirebaseFailure extends Failure {
  FirebaseFailure({required super.message})
    : super._(statusCode: ErrorPlugin.firebase.code, code: 'FIREBASE');
}

/// 🧠 [UseCaseFailure] — Errors occurring within domain use-cases.
final class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message})
    : super._(statusCode: ErrorPlugin.useCase.code, code: 'USE_CASE');
}

/// ❓ [UnknownFailure] — Fallback for unclassified or unexpected errors.
final class UnknownFailure extends Failure {
  const UnknownFailure({required super.message})
    : super._(statusCode: 'UNKNOWN');
}
