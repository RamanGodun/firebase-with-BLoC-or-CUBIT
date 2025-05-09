part of '_failure_x_imports.dart';

/// ✅ [FailureToUIModelX] — Maps [Failure] to [FailureUIModel] without localization context
extension FailureToUIModelX on Failure {
  FailureUIModel toUIModel({
    FailurePresentationType presentation = FailurePresentationType.banner,
  }) {
    return FailureUIModel(
      fallbackMessage: message,
      translationKey: translationKey,
      formattedCode: safeCode,
      icon: _resolveIcon(),
      kind: _resolveKind(),
      presentation: presentation,
    );
  }

  /// 🖼️ Internal: Icon depending on failure type
  IconData _resolveIcon() => switch (this) {
    ApiFailure() => Icons.cloud_off,
    FirebaseFailure() => Icons.fireplace,
    UseCaseFailure() => Icons.settings,
    GenericFailure(:final plugin) => switch (plugin) {
      ErrorPlugin.httpClient => Icons.wifi_off,
      ErrorPlugin.firebase => Icons.fire_extinguisher,
      ErrorPlugin.useCase => Icons.build,
      _ => Icons.error_outline,
    },
    UnauthorizedFailure() => Icons.lock,
    NetworkFailure() => Icons.signal_wifi_connected_no_internet_4,
    CacheFailure() => Icons.sd_storage,
    _ => Icons.error_outline,
  };

  /// 🎨 Internal: Kind based on semantics
  OverlayKind _resolveKind() => switch (this) {
    ApiFailure() => OverlayKind.error,
    FirebaseFailure() => OverlayKind.error,
    UnauthorizedFailure() => OverlayKind.warning,
    NetworkFailure() => OverlayKind.error,
    CacheFailure() => OverlayKind.info,
    UseCaseFailure() => OverlayKind.warning,
    GenericFailure(:final plugin) => switch (plugin) {
      ErrorPlugin.firebase => OverlayKind.error,
      ErrorPlugin.httpClient => OverlayKind.error,
      ErrorPlugin.useCase => OverlayKind.warning,
      _ => OverlayKind.error,
    },
    _ => OverlayKind.error,
  };

  /// 🎯 One-shot wrapper for state management
  Consumable<FailureUIModel> asConsumableUIModel({
    FailurePresentationType presentation = FailurePresentationType.banner,
  }) => Consumable(toUIModel(presentation: presentation));
}

/// 📌 Type of how to show error in the UI
enum FailurePresentationType { banner, snackbar, dialog }
