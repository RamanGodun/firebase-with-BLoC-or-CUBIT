import 'package:equatable/equatable.dart';
import '../utils/enums.dart';

/// 🔥 [Failure] — Domain abstraction for all app-level errors.
/// ✅ Used throughout AZER: [Either<Failure, T>]
//---------------------------------------------------------------------------

abstract class Failure extends Equatable {
  final String message;
  final String? translationKey;
  final dynamic statusCode;
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

/// 🌐 API-related failure (remote server error)
final class ApiFailure extends Failure {
  ApiFailure({required int super.statusCode, required super.message})
    : super._(code: 'API', translationKey: FailureKey.unknown.translationKey);
}

/// 🔥 Firebase failure
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

/// 🔒 Unauthorized/Expired Token (auth-based)
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

/// 📡 Connectivity issue
final class NetworkFailure extends Failure {
  NetworkFailure({required super.message, required FailureKey translationKey})
    : super._(
        statusCode: ErrorPlugin.httpClient.code,
        code: 'NETWORK',
        translationKey: translationKey.translationKey,
      );
}

/// 🧠 Business logic violation (Domain)
final class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message})
    : super._(
        statusCode: ErrorPlugin.useCase.code,
        code: 'USE_CASE',
        translationKey: FailureKey.unknown.translationKey,
      );
}

/// ⚙️ Platform/SDK failure (non-domain system issues)
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

/// 🧊 Cache/local read failure
final class CacheFailure extends Failure {
  CacheFailure({required super.message})
    : super._(
        statusCode: 'CACHE',
        code: 'CACHE',
        translationKey: FailureKey.unknown.translationKey,
      );
}

/// ❓ Unexpected/unhandled error (ASTRODES fallback)
final class UnknownFailure extends Failure {
  UnknownFailure({
    required super.message,
    FailureKey translationKey = FailureKey.unknown,
  }) : super._(
         statusCode: 'UNKNOWN',
         translationKey: translationKey.translationKey,
       );

  ///
}
