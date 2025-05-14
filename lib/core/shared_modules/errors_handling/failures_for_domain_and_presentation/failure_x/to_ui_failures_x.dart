import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_x/failure_diagnostics_x.dart';
import 'package:flutter/material.dart';
import '../../../localization/core/app_localizer.dart';
import '../../../loggers/_app_error_logger.dart';
import '../enums.dart';
import '../failure_for_domain.dart';
import '../../utils/consumable.dart';
import '../failure_ui_model.dart';

/// ✅ [FailureToUIModelX] — Maps [Failure] to [FailureUIModel] without localization context
extension FailureToUIModelX on Failure {
  ///
  FailureUIModel toUIModel() {
    final resolvedText =
        translationKey != null
            ? AppLocalizer.t(translationKey!, fallback: message)
            : message;

    if (translationKey != null && resolvedText == message) {
      AppLogger.logFailure(this, StackTrace.current);
    }

    return FailureUIModel(
      localizedMessage: resolvedText,
      formattedCode: safeCode,
      icon: _resolveIcon(),
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

  /// 🎯 One-shot wrapper for state management
  Consumable<FailureUIModel> asConsumableUIModel() => Consumable(toUIModel());

  ///

  ///
}
