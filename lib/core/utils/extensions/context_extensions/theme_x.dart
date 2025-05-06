part of '_context_extensions.dart';

/// 🎨 [ContextThemeX] — Theme-related extensions on [BuildContext]
/// ✅ Simplifies access to [ThemeData], [ColorScheme], [TextTheme], and brightness
//----------------------------------------------------------------

extension ContextThemeX on BuildContext {
  /// 🌗 Checks if current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// 🎨 Full [ThemeData] object
  ThemeData get theme => Theme.of(this);

  /// 🔤 [TextTheme] for current theme
  TextTheme get textTheme => theme.textTheme;

  /// 🎨 [ColorScheme] for current theme
  ColorScheme get colorScheme => theme.colorScheme;

  ///
}
