/*

import 'package:firebase_with_riverpod/core/modules_shared/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext, VoidCallback;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils_shared/typedef.dart';
import '../../../overlays/core/enums_for_overlay_module.dart';
import '../../failures/failure_entity.dart';

/// 🧩 [ContextAsyncValueX] — extension for showing [Failure]s from [AsyncValue]

extension RefFailureListenerX on WidgetRef {
  ///--------------------------------------

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

  ///

  /// 📦 Listen and shows erors dialog with custom [onConfirm] action
  void listenFailureWithAction<T>(
    ProviderListenable<AsyncValue<T>> provider,
    BuildContext context, {
    bool Function(Failure failure)? shouldHandle,
    required VoidCallback onConfirmed,
    VoidCallback? onCancelled,
    ShowAs showAs = ShowAs.infoDialog,
  }) {
    listen<AsyncValue<T>>(provider, (prev, next) {
      final failure = next.asFailure;
      if (failure != null && (shouldHandle?.call(failure) ?? true)) {
        context.showError(
          failure.toUIEntity(),
          showAs: showAs,
          onConfirm: onConfirmed,
          onCancel: onCancelled,
        );
      }
    });
  }

  //
}

////

////

/// 🧩 [AsyncValueX] — extension for extracting [Failure] from [AsyncError]
/// ✅ Enables typed access to domain failures in async state

extension AsyncValueX<T> on AsyncValue<T> {
  /// ─────-------------------------------

  /// ❌ Returns [Failure] if this is an [AsyncError] containing a domain failure
  Failure? get asFailure {
    final error = this;
    if (error is AsyncError && error.error is Failure) {
      return error.error as Failure;
    }
    return null;
  }

  // /
}




 */
