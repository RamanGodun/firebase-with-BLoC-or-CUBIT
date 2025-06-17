part of '../failure_entity.dart';

/// ❓ [UnknownFailure] — unhandled, uncategorized fallback
final class UnknownFailure extends Failure {
  ///---------------------------------------

  UnknownFailure({
    required super.message,
    FailureKeys translationKey = FailureKeys.unknown,
  }) : super._(
         statusCode: 'UNKNOWN',
         translationKey: translationKey.translationKey,
       );
}
