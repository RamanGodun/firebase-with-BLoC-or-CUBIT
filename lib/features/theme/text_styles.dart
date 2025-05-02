import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 🎨 [TextStyles4ThisAppThemes] — Uses Enhanced Enum for ThemeMode
/// 🧼 Clean access: TextStyles4ThisAppThemes.getTheme(AppThemeMode.dark)
abstract class TextStyles4ThisAppThemes {
  static TextTheme getTheme(AppThemeMode mode) => mode._builder.build();

  /// 🍏 Cupertino fallback (unchanged)
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

/// 🌗 [AppThemeMode] — Enhanced enum to select between dark/light theme
enum AppThemeMode {
  light(_TextStyleFactory._light),
  dark(_TextStyleFactory._dark);

  final _TextStyleFactory _builder;
  const AppThemeMode(this._builder);
}

/// 🏭 [_TextStyleFactory] — Factory for TextTheme based on brightness
class _TextStyleFactory {
  final Color color;

  const _TextStyleFactory._(this.color);

  static const _light = _TextStyleFactory._(Colors.black);
  static const _dark = _TextStyleFactory._(Colors.white);

  TextTheme build() {
    return TextTheme(
      titleLarge: _style(FontWeight.w600, 22),
      titleMedium: _style(FontWeight.w500, 19),
      titleSmall: _style(FontWeight.w400, 16),
      bodyLarge: _style(FontWeight.w400, 17),
      bodyMedium: _style(FontWeight.w400, 15),
      bodySmall: _style(FontWeight.w400, 13),
      labelLarge: _style(FontWeight.w500, 15),
      labelMedium: _style(FontWeight.w400, 13),
      labelSmall: _style(FontWeight.w400, 11),
    );
  }

  TextStyle _style(FontWeight weight, double size) {
    return TextStyle(
      fontFamily: 'SFProText',
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }
}