part of '_exceptions_to_failures_mapper.dart';

/// 🌐 [_handleSocket] — maps [SocketException] to [NetworkFailure].
/// ✅ Indicates no internet connection.
//
Failure _handleSocket(SocketException error) {
  return NetworkFailure(
    message: 'No Internet connection. Please check your settings.',
    translationKey: FailureKeys.networkNoConnection,
  );
}

////
////

/// ⏳ [_handleTimeout] — maps [TimeoutException] to [NetworkFailure].
/// ✅ Used for request timeouts or async ops exceeding duration.
//
Failure _handleTimeout(TimeoutException error) => NetworkFailure(
  translationKey: FailureKeys.networkTimeout,
  message: 'Connection timeout occurred.',
);

////
////

/// 🌍 [_handleHttp] — maps [HttpException] to [NetworkFailure].
/// ✅ Covers legacy HTTP errors (non-Dio).
//
Failure _handleHttp(HttpException error) {
  final msg = error.message.toLowerCase();

  // iOS часто каже "The Internet connection appears to be offline"
  if (msg.contains('offline') ||
      msg.contains('internet connection') ||
      msg.contains('network is unreachable')) {
    return NetworkFailure(
      message: 'No Internet connection. Please check your settings.',
      translationKey: FailureKeys.networkNoConnection,
    );
  }

  // Інакше — generic
  return NetworkFailure(
    translationKey: FailureKeys.networkTimeout,
    message: error.message,
  );
}
