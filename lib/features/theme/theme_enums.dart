import 'text_styles.dart';

///
enum FontFamilyType {
  sfPro,
  aeonik,
  poppins,
  // google
}

/// 🌗 [AppThemeMode] — Enhanced enum to select between dark/light theme
enum AppThemeMode {
  light(TextStyleFactory.light),
  dark(TextStyleFactory.dark);

  final TextStyleFactory builder;
  const AppThemeMode(this.builder);
}
