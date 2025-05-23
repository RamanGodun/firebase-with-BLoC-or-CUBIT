import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart';

/// ✅ Used in Cubit to map raw Failure into UI-ready format (icons, kinds, keys)
/// 🧩 [FailureUIModel] — Stateless model for representing a failure in the UI
/// ✅ Used in presentation layer instead of [Failure]

final class FailureUIModel extends Equatable {
  final String localizedMessage;
  final String? formattedCode;
  final IconData icon;

  const FailureUIModel({
    required this.localizedMessage,
    required this.icon,
    this.formattedCode,
  });

  @override
  @override
  List<Object?> get props => [localizedMessage, formattedCode, icon];

  ///
}
