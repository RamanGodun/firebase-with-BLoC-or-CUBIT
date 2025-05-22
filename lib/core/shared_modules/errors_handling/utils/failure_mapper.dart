import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../../logging/failure_logger_x.dart' show RawErrorLogger;
import '../failures_for_domain_and_presentation/enums.dart';
import '../failures_for_domain_and_presentation/failure_for_domain.dart';

/// 🧰 [FailureMapper] — centralized converter for raw exceptions to domain-level [Failure].
/// ✅ Converts ASTRODES into structured [Failure] types.
/// ✅ Guarantees consistent mapping across Data → Domain → UI.
final class FailureMapper {
  const FailureMapper._();

  /// 🛡️ Converts any caught error into domain-level [Failure].
  static Failure from(dynamic error, [StackTrace? stackTrace]) {
    RawErrorLogger.log(error, stackTrace);

    if (error is Failure) return error;

    return switch (error) {
      //
      SocketException _ => NetworkFailure(
        translationKey: FailureKey.networkNoConnection,
        message: 'No Internet connection. Please check your settings.',
      ),

      ///
      TimeoutException _ => NetworkFailure(
        translationKey: FailureKey.networkTimeout,
        message: 'Connection timeout occurred.',
      ),

      ///
      HttpException(:final message) => NetworkFailure(
        translationKey: FailureKey.networkTimeout,
        message: message,
      ),

      ///
      DioException(:final response) when response?.statusCode == 401 =>
        UnauthorizedFailure(message: 'Unauthorized. Please log in again.'),

      ///
      FirebaseException(:final message) => FirebaseFailure(
        message: message ?? 'Firebase error occurred.',
      ),

      ///
      PlatformException(:final code, :final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: code,
        message: message ?? 'Platform error occurred.',
        translationKey: FailureKey.formatError,
      ),

      ///
      MissingPluginException(:final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: 'MISSING_PLUGIN',
        message: message ?? 'Plugin not initialized.',
        translationKey: FailureKey.missingPlugin,
      ),

      ///
      FormatException _ => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'FORMAT_ERROR',
        message: 'Malformed data received.',
        translationKey: FailureKey.formatError,
      ),

      ///
      JsonUnsupportedObjectError(:final cause) => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'JSON_ERROR',
        message: 'Unsupported JSON: $cause',
        translationKey: FailureKey.formatError,
      ),

      ///
      DioException(:final type, :final message) => NetworkFailure(
        translationKey: FailureKey.networkTimeout,
        message: message ?? 'Dio error: ${type.name}',
      ),

      ///
      _ => UnknownFailure(message: error.toString()),

      ///
    };
  }

  //
}
