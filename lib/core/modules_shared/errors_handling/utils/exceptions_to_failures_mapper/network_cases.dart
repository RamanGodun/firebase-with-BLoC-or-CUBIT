part of '_exceptions_to_failures_mapper.dart';

/// 🌐 [_handleSocket] — maps [SocketException] to [NetworkFailure].
/// ✅ Indicates no internet connection.

Failure _handleSocket(SocketException error) => NetworkFailure(
  translationKey: FailureKeys.networkNoConnection,
  message: 'No Internet connection. Please check your settings.',
);

////

////

/// ⏳ [_handleTimeout] — maps [TimeoutException] to [NetworkFailure].
/// ✅ Used for request timeouts or async ops exceeding duration.

Failure _handleTimeout(TimeoutException error) => NetworkFailure(
  translationKey: FailureKeys.networkTimeout,
  message: 'Connection timeout occurred.',
);

////

////

/// 🌍 [_handleHttp] — maps [HttpException] to [NetworkFailure].
/// ✅ Covers legacy HTTP errors (non-Dio).

Failure _handleHttp(HttpException error) => NetworkFailure(
  translationKey: FailureKeys.networkTimeout,
  message: error.message,
);
