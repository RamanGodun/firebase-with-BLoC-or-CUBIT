import 'package:firebase_with_bloc_or_cubit/core/foundation/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import '../../failures/failure_ui_entity.dart';
import 'consumable.dart';

/// 📦 Extension to wrap any object in a [Consumable]

extension ConsumableX<T> on T {
  ///--------------------------
  //
  Consumable<T> asConsumable() => Consumable(this);
  //
}

////

////

extension FailureUIContextX on BuildContext {
  ///---------------------------------------
  //
  void consumeAndShowDialog(FailureUIEntity? model) {
    if (model != null) showError(model);
  }

  //
}
