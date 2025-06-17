part of '../failure_entity.dart';

/// 📡 [NetworkFailure] — connectivity issues (no connection / timeout)
final class NetworkFailure extends Failure {
  ///---------------------------------------

  NetworkFailure({required super.message, required FailureKeys translationKey})
    : super._(
        statusCode: ErrorPlugins.httpClient.code,
        code: 'NETWORK',
        translationKey: translationKey.translationKey,
      );
}

///

/// 🔒 [UnauthorizedFailure] — 401 token expired / not logged in
final class UnauthorizedFailure extends Failure {
  ///---------------------------------------

  UnauthorizedFailure({
    required super.message,
    FailureKeys translationKey = FailureKeys.unauthorized,
  }) : super._(
         statusCode: 401,
         code: 'UNAUTHORIZED',
         translationKey: translationKey.translationKey,
       );
}

///

/// 🌐 [ApiFailure] — HTTP/API-level failures (non-auth)
final class ApiFailure extends Failure {
  ///---------------------------------------

  ApiFailure({required int super.statusCode, required super.message})
    : super._(code: 'API', translationKey: FailureKeys.unknown.translationKey);
}
