part of '_failure_x_imports.dart';

/// 🧾 [FailureUI] — provides structured, detailed error formatting for diagnostics/UI.
extension FailureUI on Failure {
  /// Returns a formatted string with extra debug details for complex errors.
  String get formattedMessage {
    if (this is GenericFailure) {
      final error = (this as GenericFailure).error;
      return '${error.message}\n\nCode: ${error.code}\nSource: ${error.plugin.name}';
    }
    if (this is ApiFailure) {
      return '$message\n\nStatus Code: $statusCode';
    }
    return message;
  }

  ///
}
