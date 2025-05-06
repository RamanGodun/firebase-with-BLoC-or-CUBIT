import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, debugPrint;
import '../custom_error.dart';
import '../failure.dart';

/// 🧰 [FailureMapper] — Central place for mapping, logging and formatting exceptions
final class FailureMapper {
  const FailureMapper._();

  ///
  /// 🛡️ [handleException] — Maps any [Exception] or unknown error into a domain-level [Failure].
  /// Used to unify error handling across Data, Domain, and Presentation layers.
  static Failure from(dynamic error) {
    _logError(error);

    if (error is Failure) return error;

    return switch (error) {
      SocketException _ => GenericFailure(
        error: const CustomError(
          code: 'NO_INTERNET',
          message: 'No Internet connection. Please check your settings.',
          plugin: ErrorPlugin.httpClient,
        ),
      ),
      HttpException e => GenericFailure(
        error: CustomError(
          code: 'HTTP_ERROR',
          message: e.message,
          plugin: ErrorPlugin.httpClient,
        ),
      ),
      FormatException _ => GenericFailure(
        error: const CustomError(
          code: 'FORMAT_ERROR',
          message: 'Bad response format received.',
          plugin: ErrorPlugin.unknown,
        ),
      ),
      TimeoutException _ => GenericFailure(
        error: const CustomError(
          code: 'TIMEOUT',
          message: 'Connection timeout occurred.',
          plugin: ErrorPlugin.httpClient,
        ),
      ),
      _ => UnknownFailure(message: error.toString()),
    };
  }

  /// 🐞 [_logError] — Logs error details in debug mode for diagnostics.
  /// (e.g., caught exceptions before mapping them to [Failure])
  static void _logError(dynamic error) {
    if (kDebugMode) {
      final prefix = error is Failure ? '[FAILURE]' : '[UNHANDLED]';
      debugPrint('$prefix ${error.runtimeType}: $error');
    }
  }

  ///
}
