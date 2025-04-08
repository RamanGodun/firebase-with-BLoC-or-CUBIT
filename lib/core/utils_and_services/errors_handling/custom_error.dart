import 'package:flutter/foundation.dart';

/// Standard error format used across the app.
@immutable
class CustomError {
  final String code;
  final String message;
  final String plugin;

  const CustomError({this.code = '', this.message = '', this.plugin = ''});

  @override
  String toString() =>
      'CustomError(code: $code, message: $message, plugin: $plugin)';

  CustomError copyWith({String? code, String? message, String? plugin}) {
    return CustomError(
      code: code ?? this.code,
      message: message ?? this.message,
      plugin: plugin ?? this.plugin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomError &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message &&
          plugin == other.plugin;

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ plugin.hashCode;
}
