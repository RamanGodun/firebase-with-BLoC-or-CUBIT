part of '_failure_x_imports.dart';

/// 🧾 [FailureUI] — provides structured, detailed error formatting for diagnostics/UI.
//-------------------------------------------------------------------------------------

extension FailureUI on Failure {
  //
  /// Returns a formatted string with extra debug details for complex errors.
  String get formattedMessage => switch (this) {
    GenericFailure(:final plugin, :final code, :final message) =>
      '$message\n\nCode: $code\nSource: ${plugin.name}',
    ApiFailure(:final statusCode, :final message) =>
      '$message\n\nStatus Code: $statusCode',
    _ => message,
  };

  /// Human-friendly fallback message for UI display.
  String get uiMessage => message.isNotEmpty ? message : 'Something went wrong';

  /// 📌 Contextual icon for overlay usage (e.g. showError)
  IconData get overlayIcon => switch (this) {
    ApiFailure() => Icons.cloud_off,
    FirebaseFailure() => Icons.fireplace,
    UseCaseFailure() => Icons.settings,
    GenericFailure(:final plugin) => switch (plugin) {
      ErrorPlugin.httpClient => Icons.wifi_off,
      ErrorPlugin.firebase => Icons.fire_extinguisher,
      ErrorPlugin.useCase => Icons.build,
      _ => Icons.error_outline,
    },
    _ => Icons.error_outline,
  };

  ///
}
