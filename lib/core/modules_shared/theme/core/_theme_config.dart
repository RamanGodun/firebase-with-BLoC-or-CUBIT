import 'package:flutter/material.dart';
import '../text_theme/text_theme_factory.dart';
import 'theme_cache_mixin.dart';
import 'theme_type_enum.dart.dart';

/// 🎨 [ThemeConfig] — Lightweight configuration for theme and font
/// ✅ Contains only enums: [ThemeTypes] and [FontFamily]
/// 🚫 Does not hold ThemeData directly to prevent unnecessary rebuilds

@immutable
final class ThemeConfig with ThemeCacheMixin {
  ///---------------------------------------

  // Selected theme variant (light, dark, glass, amoled)
  final ThemeTypes theme;
  // Selected font family (e.g., SF Pro, Aeonik)
  final FontFamily font;

  const ThemeConfig({required this.theme, required this.font});
  //

  /// Resolves [ThemeMode] based on current theme
  ThemeMode get mode => theme.isDark ? ThemeMode.dark : ThemeMode.light;

  /// Resolves current theme brightness
  bool get isDark => theme.isDark;

  /// Returns light [ThemeData] using cache
  ThemeData buildLight() => cachedTheme(ThemeTypes.light, font);

  /// Returns dark [ThemeData] using cache
  ThemeData buildDark() => cachedTheme(ThemeTypes.dark, font);
  //

  /// Creates a copy with updated fields
  ThemeConfig copyWith({ThemeTypes? theme, FontFamily? font}) {
    return ThemeConfig(theme: theme ?? this.theme, font: font ?? this.font);
  }

  /// Human-readable label (e.g. "glass · SFProText")
  String get label => '$theme · ${font.value}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeConfig &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          font == other.font;

  @override
  int get hashCode => Object.hash(theme, font);
}
