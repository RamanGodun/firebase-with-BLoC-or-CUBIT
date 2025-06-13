part of '../failure_entity.dart';

/// 🧠 [UseCaseFailure] — validation / business logic violation
final class UseCaseFailure extends Failure {
  ///---------------------------------------

  UseCaseFailure({required super.message})
    : super._(
        statusCode: ErrorPlugin.useCase.code,
        code: 'USE_CASE',
        translationKey: FailureKey.unknown.translationKey,
      );
}

///

/// 🧊 [CacheFailure] — local storage, preferences, or disk read/write error
final class CacheFailure extends Failure {
  ///---------------------------------------

  CacheFailure({required super.message})
    : super._(
        statusCode: 'CACHE',
        code: 'CACHE',
        translationKey: FailureKey.unknown.translationKey,
      );
}
