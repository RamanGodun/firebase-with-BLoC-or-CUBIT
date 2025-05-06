import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, debugPrint;
import '../error_plugin_enums.dart';
import '../failure.dart';

/// 🧰 [FailureMapper] — Central place for mapping, logging and formatting exceptions
//-------------------------------------------------------------------------

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
        plugin: ErrorPlugin.httpClient,
        code: 'NO_INTERNET',
        message: 'No Internet connection. Please check your settings.',
      ),
      HttpException e => GenericFailure(
        plugin: ErrorPlugin.httpClient,
        code: 'HTTP_ERROR',
        message: e.message,
      ),
      FormatException _ => GenericFailure(
        plugin: ErrorPlugin.unknown,
        code: 'FORMAT_ERROR',
        message: 'Bad response format received.',
      ),
      TimeoutException _ => GenericFailure(
        plugin: ErrorPlugin.httpClient,
        code: 'TIMEOUT',
        message: 'Connection timeout occurred.',
      ),
      _ => UnknownFailure(message: error.toString()),
    };
  }

  /// 🔞 [_logError] — Logs error details in debug mode for diagnostics.
  /// (e.g., caught exceptions before mapping them to [Failure])
  static void _logError(dynamic error) {
    if (kDebugMode) {
      final prefix = error is Failure ? '[FAILURE]' : '[UNHANDLED]';
      debugPrint('$prefix ${error.runtimeType}: $error');
    }
  }

  ///
}
