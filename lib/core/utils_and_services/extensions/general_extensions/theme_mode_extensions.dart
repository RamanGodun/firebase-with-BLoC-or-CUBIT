part of '_general_extensions.dart';

extension ThemeModeX on ThemeMode {
  ThemeMode toggle() =>
      this == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}
