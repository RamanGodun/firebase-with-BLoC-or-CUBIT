part of '_context_extensions.dart';

/// 🎨 [ContextThemeX] — Theme-related extensions on [BuildContext]
extension ContextThemeX on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}
