import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, debugPrint;
import 'custom_error.dart';
import 'failure.dart';

/// 🛡️ [handleException] — universal exception mapper
/// 🧼 Converts any caught [Exception] into a domain-specific [Failure]
//----------------------------------------------------------------//
Failure handleException(dynamic error) {
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

/// 🧼 [_logError] — logs error details only in debug mode
//----------------------------------------------------------------//
void _logError(dynamic error) {
  if (kDebugMode) {
    debugPrint('[ERROR] ${error.runtimeType}: $error');
  }
}
