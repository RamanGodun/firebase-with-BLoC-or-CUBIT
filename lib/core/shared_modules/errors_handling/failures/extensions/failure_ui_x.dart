part of '_failure_x_imports.dart';

/// 🧾 [FailureUI] — provides structured, detailed error formatting for diagnostics/UI.
//-------------------------------------------------------------------------------------

extension FailureUI on Failure {
  //
  /// 🧾 Returns detailed debug message (code + plugin name)
  String get formattedMessage => switch (this) {
    GenericFailure(:final plugin, :final code, :final message) =>
      '$message\n\nCode: $code\nSource: ${plugin.name}',
    ApiFailure(:final statusCode, :final message) =>
      '$message\n\nStatus Code: $statusCode',
    _ => message,
  };

  /// 🌍 Returns localized message if possible, otherwise fallback to raw `message`
  String uiMessageOrRaw([BuildContext? context, Map<String, String>? params]) {
    try {
      if (context != null && translationKey != null) {
        final localizations = AppLocalizations.of(context);
        final translated = localizations?.translate(translationKey!, params);
        if (translated != null && translated.trim().isNotEmpty) {
          return translated;
        }
      }
    } catch (_) {
      // 🔒 Safely ignore localization's errors
    }
    return message.isNotEmpty ? message : 'Something went wrong';
  }

  // 🔁 Method with UI (to use in UI layer)
  String uiMessage(BuildContext context) => uiMessageOrRaw(context);

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
