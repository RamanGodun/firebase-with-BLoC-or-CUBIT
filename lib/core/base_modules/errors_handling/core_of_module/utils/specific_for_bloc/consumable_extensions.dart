import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/failure_ui_mapper.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import '../../failure_entity.dart';
import '../../failure_ui_entity.dart';
import 'consumable.dart';

/// 📦 Extension to wrap Failure into a one-time consumable UI object
//
extension FailureConsumableX on Failure {
  /// 🎯 Wraps [FailureUIEntity] into a [Consumable]
  Consumable<FailureUIEntity> asConsumableUIEntity() =>
      Consumable(toUIEntity());
}

////

////

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
  void consumeAndShowDialog(FailureUIEntity? model) {
    if (model != null) showError(model);
  }
}
