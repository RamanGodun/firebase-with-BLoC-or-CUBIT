import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart' show sealed;

/// 🧩 [FailureUIEntity] — UI-layer representation of a domain failure
/// ✅ Uses i18n translation key from [FailureType]
/// ✅ Contains icon and human-readable error code
///
@sealed
final class FailureUIEntity extends Equatable {
  final String localizedMessage; //📝 Localized error text for display
  final String formattedCode; //🔖 e.g., "401" or "FIREBASE"
  final IconData icon; //🎨 Icon representing error type

  const FailureUIEntity({
    required this.localizedMessage,
    required this.formattedCode,
    required this.icon,
  });

  @override
  List<Object?> get props => [localizedMessage, formattedCode, icon];
}
