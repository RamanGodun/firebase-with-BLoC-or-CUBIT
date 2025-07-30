import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/failure_diagnostics_x.dart';
import 'package:flutter/material.dart';
import '../../errors_handling/failures/failure_entity.dart';

/// 🧭 [FailureNavigationX] — Handles redirection/navigation scenarios based on failure type
/// ✅ Recommended for handling auth/navigation flows declaratively
//
extension FailureNavigationX on Failure {
  /// -----------------------------------
  //
  /// 📡 Navigates to login screen or callback when unauthorized (401)
  /// ⚠️ This is an example — replace [onUnauthorized] with actual implementation in your app
  Failure redirectIfUnauthorized(VoidCallback onUnauthorized) {
    if (isUnauthorized) onUnauthorized();
    return this;
  }

  //
}
