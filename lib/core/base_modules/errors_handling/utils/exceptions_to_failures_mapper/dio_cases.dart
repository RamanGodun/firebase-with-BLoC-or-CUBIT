part of '_exceptions_to_failures_mapper.dart';

/// 🌍 [_handleDio] — maps Dio-specific exceptions to [Failure]s.
/// ✅ Covers timeouts, client/server HTTP errors, and unknown types.
/// ✅ Ensures uniform translation from Dio to domain layer.
//
Failure _handleDio(DioException error) => switch (error.type) {
  /// ──---------------------------------------------------

  //⏱️ Timeout-related Dio errors
  DioExceptionType.connectionTimeout ||
  DioExceptionType.receiveTimeout ||
  DioExceptionType.sendTimeout => NetworkFailure(
    translationKey: FailureKeys.networkTimeout,
    message: error.message ?? 'Connection timed out.',
  ),

  //📡 Bad response from server
  DioExceptionType.badResponse => switch (error.response?.statusCode) {
    //
    final code? when code == 401 => UnauthorizedFailure(
      message: 'Unauthorized. Please log in again.',
      translationKey: FailureKeys.unauthorized,
    ),

    final code? when code >= 400 && code < 500 => ApiFailure(
      statusCode: code,
      message: 'Client error occurred.',
    ),

    final code? when code >= 500 => ApiFailure(
      statusCode: code,
      message: 'Server error occurred.',
    ),

    _ => ApiFailure(
      statusCode: error.response?.statusCode ?? 0,
      message: 'Unexpected HTTP error.',
    ),
  },

  //❗ Fallback for other Dio types
  _ => NetworkFailure(
    translationKey: FailureKeys.networkTimeout,
    message: error.message ?? 'Dio network error: ${error.type.name}',
  ),

  //
};
