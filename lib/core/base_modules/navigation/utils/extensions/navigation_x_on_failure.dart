import 'package:flutter/material.dart';
import '../../../errors_handling/core_of_module/failure_entity.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/extensible_part/failure_extensions/failure_diagnostics_x.dart';

/// 🧭 [FailureNavigationX] — Handles redirection/navigation scenarios based on failure type
/// ✅ Recommended for handling auth/navigation flows declaratively
//
extension FailureNavigationX on Failure {
  /// -----------------------------------
  //
  /// 📡 Navigates to login screen or callback when unauthorized (401)
  /// ⚠️ This is an example — replace [onUnauthorizedCallback] with actual implementation in your app
  Failure redirectIfUnauthorized(VoidCallback onUnauthorizedCallback) {
    if (isUnauthorizedFailure) onUnauthorizedCallback();
    return this;
  }

  //
}
