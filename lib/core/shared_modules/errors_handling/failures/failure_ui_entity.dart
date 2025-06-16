import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart' show sealed;

/// 🧩 [FailureUIEntity] — UI-layer representation of a domain failure
/// ✅ Used in to show localized message, icon, and error code
/// ✅ Stateless and equatable (used in `context.showError(...)`)

@sealed
final class FailureUIEntity extends Equatable {
  //-------------------------------------

  final String localizedMessage; //📝 Localized error text for display
  final String? formattedCode; //🔖 Optional code label (e.g., 401, FIREBASE)
  final IconData icon; //🎨 Icon representing error type

  const FailureUIEntity({
    required this.localizedMessage,
    required this.icon,
    this.formattedCode,
  });

  @override
  List<Object?> get props => [localizedMessage, formattedCode, icon];

  //
}
