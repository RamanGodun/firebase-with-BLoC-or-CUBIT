import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../extensions/_failure_x_imports.dart' show RawErrorLogger;
import '../failure_keys_enum.dart';
import 'error_plugin_enums.dart';
import '../failure.dart';

/// 🧰 [FailureMapper] — centralized converter for raw exceptions to domain-level [Failure].
/// ✅ Converts raw system-level exceptions (e.g. Dio, Firebase, Platform, IO)
///    into strongly-typed domain-specific [Failure] models.
/// ✅ Guarantees consistent error handling across all layers (Data → Domain → UI).
/// -------------------------------------------------------------------------

final class FailureMapper {
  const FailureMapper._();

  /// 🛡️ [from] — Converts any [Exception] (or unknown object) to a domain-specific [Failure].
  static Failure from(dynamic error, [StackTrace? stackTrace]) {
    ///  * ❗ Logging responsibility has been moved to [RawErrorLogger].
    RawErrorLogger.log(error, stackTrace);

    if (error is Failure) return error;

    ///
    // 📦 Known exception mapping to domain-level Failures
    return switch (error) {
      ///
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
        UnauthorizedFailure(
          translationKey: FailureKey.unauthorized,
          message: 'Unauthorized access. Please log in again.',
        ),

      ///
      FirebaseException(:final message) => FirebaseFailure(
        translationKey: FailureKey.firebaseGeneric,
        message: message ?? 'Firebase error occurred.',
      ),

      ///
      PlatformException(:final code, :final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: code,
        translationKey: FailureKey.formatError,
        message: message ?? 'Platform error occurred.',
      ),

      ///
      MissingPluginException(:final message) => GenericFailure(
        plugin: ErrorPlugin.useCase,
        code: 'MISSING_PLUGIN',
        translationKey: FailureKey.missingPlugin,
        message: message ?? 'Plugin not found or not initialized.',
      ),

      ///
      FormatException _ => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'FORMAT_ERROR',
        translationKey: FailureKey.formatError,
        message: 'Bad response format received.',
      ),

      ///
      JsonUnsupportedObjectError(:final cause) => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'JSON_ERROR',
        translationKey: FailureKey.formatError,
        message: 'Unsupported JSON structure: $cause',
      ),

      ///
      DioException(:final type, :final message) => NetworkFailure(
        translationKey: FailureKey.networkTimeout,
        message: message ?? 'Dio error occurred. Type: ${type.name}',
      ),

      ///
      _ => UnknownFailure(
        translationKey: FailureKey.unknown,
        message: error.toString(),
      ),

      ///
    };
  }

  ///
}
