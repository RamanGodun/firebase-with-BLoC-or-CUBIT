part of '_failure_x_imports.dart';

/// 🧾 [FailureUI] — provides structured, detailed error formatting for diagnostics/UI.
//-------------------------------------------------------------------------

extension FailureUI on Failure {
  //
  /// Returns a formatted string with extra debug details for complex errors.
  String get formattedMessage {
    if (this is GenericFailure) {
      final f = this as GenericFailure;
      return '${f.message}\n\nCode: ${f.code}\nSource: ${f.plugin.name}';
    }
    if (this is ApiFailure) {
      return '$message\n\nStatus Code: $statusCode';
    }
    return message;
  }

  ///
}
