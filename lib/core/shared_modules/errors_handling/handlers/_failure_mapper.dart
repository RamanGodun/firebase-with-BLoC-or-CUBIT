import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../loggers/app_error_logger.dart';
import '../failures/failure_key.dart';
import 'error_plugin_enums.dart';
import '../failures/failure.dart';

/// 🧰 [FailureMapper] — Central place for mapping, logging and formatting exceptions
/// -------------------------------------------------------------------------
final class FailureMapper {
  const FailureMapper._();

  /// 🛡️ [from] — Maps any [Exception] or unknown error into a domain-level [Failure].
  /// Used to unify error handling across Data, Domain, and Presentation layers.
  static Failure from(dynamic error, [StackTrace? stackTrace]) {
    _logRawError(error, stackTrace);

    if (error is Failure) return error;

    return switch (error) {
      SocketException _ => NetworkFailure(
        key: FailureKey.networkNoConnection,
        message: 'No Internet connection. Please check your settings.',
      ),
      TimeoutException _ => NetworkFailure(
        key: FailureKey.networkTimeout,
        message: 'Connection timeout occurred.',
      ),
      HttpException(:final message) => NetworkFailure(
        key: FailureKey.networkTimeout,
        message: message,
      ),

      DioException(:final response) when response?.statusCode == 401 =>
        UnauthorizedFailure(
          key: FailureKey.unauthorized,
          message: 'Unauthorized access. Please log in again.',
        ),

      FirebaseException(:final message) => FirebaseFailure(
        key: FailureKey.firebaseGeneric,
        message: message ?? 'Firebase error occurred.',
      ),

      PlatformException(:final code, :final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: code,
        key: FailureKey.formatError,
        message: message ?? 'Platform error occurred.',
      ),

      MissingPluginException(:final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: 'MISSING_PLUGIN',
        key: FailureKey.missingPlugin,
        message: message ?? 'Plugin not found or not initialized.',
      ),

      FormatException _ => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'FORMAT_ERROR',
        key: FailureKey.formatError,
        message: 'Bad response format received.',
      ),

      JsonUnsupportedObjectError(:final cause) => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'JSON_ERROR',
        key: FailureKey.formatError,
        message: 'Unsupported JSON structure: $cause',
      ),

      DioException(:final type, :final message) => NetworkFailure(
        key: FailureKey.networkTimeout,
        message: message ?? 'Dio error occurred. Type: ${type.name}',
      ),

      _ => UnknownFailure(key: FailureKey.unknown, message: error.toString()),
    };
  }

  /// 🔎 [_logRawError] — Logs details to Crashlytics (and console in debug)
  ///    **before** mapping to [Failure]
  static void _logRawError(Object error, [StackTrace? stackTrace]) {
    AppErrorLogger.logException(error, stackTrace);
  }

  ///
}
