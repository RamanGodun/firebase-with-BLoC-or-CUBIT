import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import '../../failure_ui_entity.dart';
import 'consumable.dart';

/// 📦 Extension to wrap any object in a [Consumable]
//
extension ConsumableX<T> on T {
  ///--------------------------
  //
  Consumable<T> asConsumable() => Consumable(this);
}

////
////

/// 📦 Extension to one-time error show
//
extension FailureUIContextX on BuildContext {
  ///---------------------------------------
  //
  void consumeAndShowDialog(FailureUIEntity? uiFailure) {
    if (uiFailure != null) showError(uiFailure);
  }
}
