import 'package:flutter/material.dart';
import '../../shared_presentation/constants/_app_constants.dart';
import 'text_theme/_text_styles.dart';
import 'components/theming_enums.dart';

part '_themes_factory.dart';

/// 🎨 [AppThemes] — Scalable theme generator for the app
/// Used to build [ThemeData] for MaterialApp based on:
/// - Selected [AppThemeType]
/// - Optional custom font (e.g. for dynamic switching)
//----------------------------------------------------------------

abstract interface class AppThemes {
  /// 🧬 Resolves a complete [ThemeData] from a available theme type options
  static ThemeData resolve(AppThemeType variant, {FontFamilyType? font}) =>
      _ThemeFactory(variant).build(font: font);

  /// 🧪 Previews light/dark theme (used in toggles or previews)
  static ThemeData preview({bool isDark = false}) =>
      _ThemeFactory(isDark ? AppThemeType.dark : AppThemeType.light).build();

  ///
}
