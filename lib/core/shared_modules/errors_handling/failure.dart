import 'package:equatable/equatable.dart';
import 'error_plugin_enums.dart';

/// 🔥 [Failure] — Abstract base class for domain-level failures.
/// ✅ Used in [Either<Failure, T>] to handle errors safely across layers
/// ✅ Supports structured debugging, plugin source tracking, and equality
//---------------------------------------------------------------------------
abstract class Failure extends Equatable {
  /// Descriptive human-readable error message
  final String message;
  // Optional technical code or status (e.g. HTTP, plugin-specific)
  final dynamic statusCode;
  // Optional domain-level app-specific code
  final String? code;

  const Failure._({required this.message, this.statusCode, this.code});

  @override
  List<Object?> get props => [message, statusCode, code];
}

//----------------------------------------------------------------------------

/// 🌐 [ApiFailure] — HTTP or GraphQL-related failure from remote source.
/// ✅ Contains status code + message
final class ApiFailure extends Failure {
  const ApiFailure({required int super.statusCode, required super.message})
    : super._(code: 'API');
}

/// ⚙️ [GenericFailure] — Platform or SDK error (e.g. no internet, format error, timeout).
/// ✅ Includes plugin source, custom code, and message
final class GenericFailure extends Failure {
  final ErrorPlugin plugin;

  GenericFailure({
    required this.plugin,
    required String super.code,
    required super.message,
  }) : super._(statusCode: plugin.code);

  @override
  List<Object?> get props => super.props..add(plugin);
}

/// 🔥 [FirebaseFailure] — Firebase service-related failure.
/// ✅ Wraps Firebase errors with source tagging
final class FirebaseFailure extends Failure {
  FirebaseFailure({required super.message})
    : super._(statusCode: ErrorPlugin.firebase.code, code: 'FIREBASE');
}

/// 🧠 [UseCaseFailure] — Application logic or business rule violation.
/// ✅ Originates from domain-level use cases
final class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message})
    : super._(statusCode: ErrorPlugin.useCase.code, code: 'USE_CASE');
}

/// ❓ [UnknownFailure] — Catch-all fallback for unexpected/unmapped errors.
/// ✅ Used when no concrete error type applies
final class UnknownFailure extends Failure {
  const UnknownFailure({required super.message})
    : super._(statusCode: 'UNKNOWN');
}
