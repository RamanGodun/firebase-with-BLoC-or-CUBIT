import 'package:flutter/material.dart';

/// ✅ Used in Cubit to map raw Failure into UI-ready format (icons, kinds, keys)
/// 🧩 [FailureUIModel] — Stateless model for representing a failure in the UI
/// ✅ Used in presentation layer instead of [Failure]

final class FailureUIModel {
  final String fallbackMessage;
  final String? translationKey;
  final String? formattedCode;
  final IconData icon;

  const FailureUIModel({
    required this.fallbackMessage,
    required this.icon,
    this.translationKey,
    this.formattedCode,
  });
}
