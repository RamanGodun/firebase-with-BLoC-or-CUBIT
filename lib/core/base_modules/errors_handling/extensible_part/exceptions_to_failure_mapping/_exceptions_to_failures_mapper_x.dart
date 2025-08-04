part of '../../core_of_module/_run_errors_handling.dart';

/// 📦 [ExceptionToFailureX] — Extension to map any [Object] (Exception/Error) to a domain-level [Failure]
/// ✅ Handles known exceptions and maps them declaratively via [FailureFactory]
/// ✅ Clean, centralized, consistent fallback logic
//
extension ExceptionToFailureX on Object {
  ///
  //
  Failure mapToFailure([StackTrace? stackTrace]) => switch (this) {
    //
    /// 🌐 No internet connection
    SocketException error => Failure(
      type: const NetworkFailureType(),
      message: error.message,
    ),

    /// 🔢 JSON encoding/decoding error
    JsonUnsupportedObjectError error => Failure(
      type: const JsonErrorFailureType(),
      message: error.toString(),
    ),

    /// 🔌 Dio error handler
    DioException error => _mapDioError(error),

    /// 🔥 Firebase error code handling
    FirebaseException error =>
      _firebaseFailureMap[error.code]?.call(error.message) ??
          () {
            final failure = Failure(
              type: const GenericFirebaseFailureType(),
              message: error.message,
            );
            // Fallback's logging
            failure.log(stackTrace);
            return failure;
          }(),

    /// 📄 Firestore-specific malformed data
    FormatException error when error.message.contains('document') => Failure(
      type: const DocMissingFirebaseFailureType(),
      message: error.message,
    ),

    /// ⚙️ Platform channel errors
    PlatformException error => Failure(
      type: const FormatFailureType(),
      message: error.message,
    ),

    /// 🧩 Plugin missing
    MissingPluginException error => Failure(
      type: const MissingPluginFailureType(),
      message: error.toString(),
    ),

    /// 🧾 Format parsing error
    FormatException error => Failure(
      type: const FormatFailureType(),
      message: error.message,
    ),

    /// 💾  Cache-related error local storage failure
    FileSystemException error => Failure(
      type: const CacheFailureType(),
      message: error.message,
    ),

    /// ⏳ Timeout reached
    TimeoutException error => Failure(
      type: const NetworkTimeoutFailureType(),
      message: error.message,
    ),
    //

    /// ❓ Unknown fallback (use toString() if message absent)
    _ => () {
      final failure = Failure(
        type: const UnknownFailureType(),
        message: toString(),
      );
      failure.log(stackTrace);
      return failure;
    }(),

    //
  };
}
