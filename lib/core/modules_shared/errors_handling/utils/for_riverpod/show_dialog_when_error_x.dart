/*

import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../general_utils/typedef.dart';
import '../../failures/failure_entity.dart';

/// 🧩 [ContextAsyncValueX] — extension for showing [Failure]s from [AsyncValue]
// extension RefFailureListenerX on WidgetRef {
//   void listenFailure<T>(
//     ProviderListenable<AsyncValue<T>> provider,
//     BuildContext context,
//   ) {
//     listen<AsyncValue<T>>(provider, (prev, next) {
//       final failure = next.asFailure;
//       if (failure != null) context.showError(failure.toUIEntity());
//     });
//   }
// }
extension RefFailureListenerX on WidgetRef {
  void listenFailure<T>(
    ProviderListenable<AsyncValue<T>> provider,
    BuildContext context, {
    ListenFailureCallback? onFailure,
  }) {
    listen<AsyncValue<T>>(provider, (prev, next) {
      final failure = next.asFailure;
      if (failure != null) {
        onFailure?.call(failure);
        context.showError(failure.toUIEntity());
      }
    });
  }
}

/// 🧩 [AsyncValueX] — extension for extracting [Failure] from [AsyncError]
/// ✅ Enables typed access to domain failures in async state
/// ─────
extension AsyncValueX<T> on AsyncValue<T> {
  /// ❌ Returns [Failure] if this is an [AsyncError] containing a domain failure
  Failure? get asFailure {
    final error = this;
    if (error is AsyncError && error.error is Failure) {
      return error.error as Failure;
    }
    return null;
  }
}


 */
