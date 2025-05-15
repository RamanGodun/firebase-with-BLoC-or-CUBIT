import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_errors_handling/failures_for_domain_and_presentation/failure_x/failure_diagnostics_x.dart';
import 'package:flutter/material.dart';
import '../failure_for_domain.dart';

/// 🧭 [FailureNavigationX] — Handles redirection/navigation scenarios based on failure type
/// ✅ Recommended for handling auth/navigation flows declaratively
// -----------------------------------------------------------------------------
extension FailureNavigationX on Failure {
  /// 📡 Navigates to login screen or callback when unauthorized (401)
  /// ⚠️ This is an example — replace [onUnauthorized] with actual implementation in your app
  Failure redirectIfUnauthorized(VoidCallback onUnauthorized) {
    if (isUnauthorized) onUnauthorized();
    return this;
  }
}
