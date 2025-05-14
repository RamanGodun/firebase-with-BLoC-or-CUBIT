import 'package:flutter/material.dart';
import '../core/translation_resolver.dart';

/// 📌 Extension for `AppStrings.someKey.tr(context)`
extension AppStringsTrX on String {
  String tr(BuildContext context) => LocalizationResolver.tr(context, this);
}
