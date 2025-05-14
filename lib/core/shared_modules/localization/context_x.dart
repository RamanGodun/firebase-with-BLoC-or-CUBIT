import 'package:flutter/material.dart';
import 'app_localization_utils.dart';

/// 📌 Extension for `AppStrings.someKey.tr(context)`
extension AppStringsTrX on String {
  String tr(BuildContext context) => AppLocalizationUtils.tr(context, this);
}
