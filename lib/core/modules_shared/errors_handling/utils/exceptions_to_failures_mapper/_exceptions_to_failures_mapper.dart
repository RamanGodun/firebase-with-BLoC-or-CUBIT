import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../observers/loggers/errors_log_util.dart';
import '../../enums/error_plugins.dart';
import '../../failures/failure_entity.dart';

part 'dio_cases.dart';
part 'firebase_cases.dart';
part 'network_cases.dart';
part 'platform_cases.dart';
part 'domain_cases.dart';

/// 🧰 [ExceptionToFailureMapper] — centralized converter for raw exceptions to domain-level [Failure].
/// ✅ Converts ASTRODES into structured [Failure] types.
/// ✅ Guarantees consistent mapping across Data → Domain → UI.

final class ExceptionToFailureMapper {
  const ExceptionToFailureMapper._();
  //---------------------

  /// 🛡️ Converts any caught error into domain-level [Failure].
  static Failure from(dynamic error, [StackTrace? stackTrace]) {
    //
    ErrorsLogger.log(error, stackTrace);

    if (error is Failure) return error; // ! 🧼 Already mapped — passthrough

    ///
    return switch (error) {
      //
      //🌐 No connection
      SocketException _ => _handleSocket(error),

      //⏳ Timeout
      TimeoutException _ => _handleTimeout(error),

      //🌍 Legacy HTTP error
      HttpException _ => _handleHttp(error),

      //🔌 Dio error handler
      DioException _ => _handleDio(error),

      //🧊 Firebase edge-case
      FirebaseAuthException _ => _handleFirebaseAuth(error),

      //🔥 Firebase codes
      FirebaseException _ => _handleFirebase(error),

      //📄 Firestore-specific parsing issue
      FormatException(:final message)
          when message.contains('document') == true =>
        FirestoreDocMissingFailure(),

      //⚙️ Native platform
      PlatformException _ => _handlePlatform(error),

      //📦 Plugin missing
      MissingPluginException _ => _handleMissingPlugin(error),

      //🧾 Bad format
      FormatException _ => _handleFormat(error),

      //🧬 JSON failure
      JsonUnsupportedObjectError _ => _handleJson(error),

      //💾 Storage error
      FileSystemException _ => _handleFileSystem(error),

      //🧠 Invalid arguments
      ArgumentError _ => _handleArgument(error),

      //❓ Fallback for uncategorized
      _ => UnknownFailure(
        message: error.toString(),
        translationKey: FailureKeys.unknown,
      ),
    };

    //
  }

  //
}
