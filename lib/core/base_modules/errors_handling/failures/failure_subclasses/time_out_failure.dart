part of '../failure__entity.dart';

/// ⏱️ [TimeoutFailure] — request took too long or didn't complete in time
/// ✅ Useful for detecting and retrying slow network / API conditions
//
final class TimeoutFailure extends Failure {
  ///---------------------------------------
  //
  TimeoutFailure({
    required super.message,
    FailureKeys translationKey = FailureKeys.timeout,
  }) : super._(
         statusCode: ErrorPlugins.httpClient.code,
         code: 'TIMEOUT',
         translationKey: translationKey.translationKey,
       );
  //
}
