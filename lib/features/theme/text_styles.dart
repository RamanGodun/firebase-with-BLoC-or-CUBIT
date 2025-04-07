import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 🎨 **[TextStyles4ThisAppThemes]** - Defines typography styles for the application.
abstract class TextStyles4ThisAppThemes {
  /// 📌 **SF Pro Text Theme**
  static TextTheme kTextThemeData(bool isDarkTheme) {
    return TextTheme(
      titleLarge: _getTextStyle(isDarkTheme, FontWeight.w600, 22),
      titleMedium: _getTextStyle(isDarkTheme, FontWeight.w500, 19),
      titleSmall: _getTextStyle(isDarkTheme, FontWeight.w400, 16),
      bodyLarge: _getTextStyle(isDarkTheme, FontWeight.w400, 17),
      bodyMedium: _getTextStyle(isDarkTheme, FontWeight.w400, 15),
      bodySmall: _getTextStyle(isDarkTheme, FontWeight.w400, 13),
      labelLarge: _getTextStyle(isDarkTheme, FontWeight.w500, 15),
      labelMedium: _getTextStyle(isDarkTheme, FontWeight.w400, 13),
      labelSmall: _getTextStyle(isDarkTheme, FontWeight.w400, 11),
    );
  }

  /// 🔧 **Reusable text style generator**
  static TextStyle _getTextStyle(
      bool isDarkTheme, FontWeight fontWeight, double fontSize) {
    return TextStyle(
      fontFamily: 'SFProText',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: isDarkTheme ? Colors.white : Colors.black,
    );
  }

  /// 🍏 **Cupertino Text Theme for iOS styling**
  static CupertinoTextThemeData getCupertinoTextStyle(BuildContext context) {
    return const CupertinoTextThemeData(
      primaryColor: CupertinoColors.label,
      textStyle: TextStyle(
        fontFamily: 'SFProText',
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: CupertinoColors.label,
      ),
    );
  }
}
