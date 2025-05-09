import 'package:equatable/equatable.dart';
import 'handlers/error_plugin_enums.dart';
import 'handlers/failure_keys_enum.dart';

/// 🔥 [Failure] — Abstract base class for domain-level failures.
/// ✅ Used in [Either<Failure, T>] to handle errors safely across layers
/// ✅ Supports structured debugging, plugin source tracking, and equality
//---------------------------------------------------------------------------
abstract class Failure extends Equatable {
  /// 💬 Descriptive fallback error message (used if no localization is present)
  final String message;

  /// 🔑 Localization key (can be used with AppLocalizations or custom i18n system)
  final String? translationKey;

  /// 🧾 Optional technical code or status (e.g. HTTP code, plugin error code)
  final dynamic statusCode;

  /// 🧱 Optional domain-level app-specific code
  final String? code;

  const Failure._({
    required this.message,
    this.translationKey,
    this.statusCode,
    this.code,
  });

  @override
  List<Object?> get props => [message, translationKey, statusCode, code];
}

//----------------------------------------------------------------------------

/// 🌐 [ApiFailure] — HTTP or GraphQL-related failure from remote source.
/// ✅ Contains status code + message
final class ApiFailure extends Failure {
  ApiFailure({required int super.statusCode, required super.message})
    : super._(code: 'API', translationKey: FailureKey.unknown.translationKey);
}

/// ⚙️ [GenericFailure] — Platform or SDK error (e.g. no internet, format error, timeout).
/// ✅ Includes plugin source, custom code, and message
final class GenericFailure extends Failure {
  final ErrorPlugin plugin;

  GenericFailure({
    required this.plugin,
    required String super.code,
    required super.message,
    FailureKey? translationKey,
  }) : super._(
         statusCode: plugin.code,
         translationKey: translationKey?.translationKey,
       );

  @override
  List<Object?> get props => super.props..add(plugin);
}

/// 🔥 [FirebaseFailure] — Firebase service-related failure.
/// ✅ Wraps Firebase errors with source tagging
final class FirebaseFailure extends Failure {
  FirebaseFailure({
    required super.message,
    FailureKey translationKey = FailureKey.firebaseGeneric,
  }) : super._(
         statusCode: ErrorPlugin.firebase.code,
         code: 'FIREBASE',
         translationKey: translationKey.translationKey,
       );
}

/// 🧠 [UseCaseFailure] — Application logic or business rule violation.
/// ✅ Originates from domain-level use cases
final class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message})
    : super._(
        statusCode: ErrorPlugin.useCase.code,
        code: 'USE_CASE',
        translationKey: FailureKey.unknown.translationKey,
      );
}

/// ❓ [UnknownFailure] — Catch-all fallback for unexpected/unmapped errors.
/// ✅ Used when no concrete error type applies
final class UnknownFailure extends Failure {
  UnknownFailure({
    required super.message,
    FailureKey translationKey = FailureKey.unknown,
  }) : super._(
         statusCode: 'UNKNOWN',
         translationKey: translationKey.translationKey,
       );
}

/// 📡 [NetworkFailure] — Specific failure for connectivity issues
/// ✅ Helps distinguish between generic and network-related failures
final class NetworkFailure extends Failure {
  NetworkFailure({required super.message, required FailureKey translationKey})
    : super._(
        statusCode: ErrorPlugin.httpClient.code,
        code: 'NETWORK',
        translationKey: translationKey.translationKey,
      );
}

/// 🔒 [UnauthorizedFailure] — User is not authenticated or token expired
/// ✅ Enables redirect to login screen or session recovery logic
final class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({
    required super.message,
    FailureKey translationKey = FailureKey.unauthorized,
  }) : super._(
         statusCode: 401,
         code: 'UNAUTHORIZED',
         translationKey: translationKey.translationKey,
       );
}

/// 🧊 [CacheFailure] — Cache is missing or invalid
/// ✅ Useful when working with local storage or memory cache
final class CacheFailure extends Failure {
  CacheFailure({required super.message})
    : super._(
        statusCode: 'CACHE',
        code: 'CACHE',
        translationKey: FailureKey.unknown.translationKey,
      );
}
