import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/theming_enums.dart';

part 'text_styles_factory.dart';
part 'typography_factory.dart';

/// 🧩 [AppTextStyles] — Entry point for accessing themed [TextTheme] & [CupertinoTextThemeData]
/// ✅ Centralized typography resolver used across both Material & Cupertino widgets
//----------------------------------------------------------------

abstract final class AppTextStyles {
  /// 🎨 Returns themed [TextTheme],
  /// based on selected [AppThemeMode] + optional [FontFamilyType]
  static TextTheme getTextTheme(AppThemeMode mode, {FontFamilyType? font}) =>
      mode.builder.build(font);

  /// 🍏 Returns [CupertinoTextThemeData] with custom font + color
  static CupertinoTextThemeData getCupertinoTextStyle(
    BuildContext context, {
    FontFamilyType font = FontFamilyType.sfPro,
  }) {
    return CupertinoTextThemeData(
      primaryColor: CupertinoColors.label,
      textStyle: TextStyle(
        fontFamily: font.value,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: CupertinoColors.label,
      ),
    );
  }

  //
}
