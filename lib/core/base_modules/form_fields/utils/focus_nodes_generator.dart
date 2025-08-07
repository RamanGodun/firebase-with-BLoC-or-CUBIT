import 'package:flutter/material.dart';
import '../input_validation/validation_enums.dart';

Map<InputFieldType, FocusNode> generateFocusNodes(Set<InputFieldType> fields) {
  return {for (final f in fields) f: FocusNode()};
}

// Usage:
// final nodes = generateFocusNodes({InputFieldType.email, InputFieldType.password});
// nodes[InputFieldType.email]!.requestFocus();
