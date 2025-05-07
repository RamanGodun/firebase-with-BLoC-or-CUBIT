import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../app_logger.dart';
import '../error_plugin_enums.dart';
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
      // 🌐 Network-related errors
      SocketException _ => NetworkFailure(
        message: 'No Internet connection. Please check your settings.',
      ),
      TimeoutException _ => NetworkFailure(
        message: 'Connection timeout occurred.',
      ),
      HttpException(:final message) => NetworkFailure(message: message),

      // 🔐 Unauthorized access (e.g. 401)
      DioException(:final response) when response?.statusCode == 401 =>
        const UnauthorizedFailure(
          message: 'Unauthorized access. Please log in again.',
        ),

      // 🔥 Firebase-related exceptions
      FirebaseException(:final message) => FirebaseFailure(
        message: message ?? 'Firebase error occurred.',
      ),

      // 🧱 Platform-related exceptions
      PlatformException(:final code, :final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: code,
        message: message ?? 'Platform error occurred.',
      ),

      // 📦 Plugin-related exceptions
      MissingPluginException(:final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: 'MISSING_PLUGIN',
        message: message ?? 'Plugin not found or not initialized.',
      ),

      // 📄 Format/JSON exceptions
      FormatException _ => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'FORMAT_ERROR',
        message: 'Bad response format received.',
      ),
      JsonUnsupportedObjectError(:final cause) => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'JSON_ERROR',
        message: 'Unsupported JSON structure: $cause',
      ),

      // 🛠️ Dio-specific errors (non-401)
      DioException(:final type, :final message) => NetworkFailure(
        message: message ?? 'Dio error occurred. Type: ${type.name}',
      ),

      // 🟡 Fallback for unknown errors
      _ => UnknownFailure(message: error.toString()),
    };
  }

  /// 🔎 [_logRawError] — Logs details to Crashlytics (and console in debug)
  ///    **before** mapping to [Failure]
  static void _logRawError(Object error, [StackTrace? stackTrace]) {
    AppErrorLogger.logException(error, stackTrace);
  }

  ///
}
