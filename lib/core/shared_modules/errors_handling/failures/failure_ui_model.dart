import 'package:flutter/material.dart';
import '../../overlay/core/overlay_kind.dart';
import 'extensions/_failure_x_imports.dart';
import 'failure.dart';

/// ✅ Used in Cubit to map raw Failure into UI-ready format (icons, kinds, keys)
/// 🧩 [FailureUIModel] — Stateless model for representing a failure in the UI
/// ✅ Used in presentation layer instead of [Failure]
final class FailureUIModel {
  final String fallbackMessage;
  final String? translationKey;
  final String? formattedCode;
  final IconData icon;
  final OverlayKind kind;
  final FailurePresentationType presentation;

  const FailureUIModel({
    required this.fallbackMessage,
    required this.icon,
    required this.kind,
    required this.presentation,
    this.translationKey,
    this.formattedCode,
  });
}
