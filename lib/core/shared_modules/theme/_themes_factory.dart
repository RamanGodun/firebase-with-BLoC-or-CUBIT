part of 'app_themes.dart';

/// 🏭 [_ThemeFactory] — Internal factory class for building complete [ThemeData] objects
/// 🔧 Converts a strongly-typed [AppThemeType] into a fully styled theme configuration
//----------------------------------------------------------------

class _ThemeFactory {
  final AppThemeType variant;
  const _ThemeFactory(this.variant);

  /// 🧱 Builds a fully configured [ThemeData]
  ThemeData build({FontFamilyType? font}) {
    final fontValue = (font ?? variant.font).value;

    return ThemeData(
      brightness: variant.brightness,
      scaffoldBackgroundColor: variant.background,
      primaryColor: variant.primaryColor,
      colorScheme: variant.colorScheme,
      appBarTheme: _buildAppBarTheme(fontValue),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textTheme: AppTextStyles.getTextTheme(variant.appThemeMode, font: font),
      cardTheme: _buildCardTheme(),
    );
  }

  /// 🔷 AppBar styling configuration
  AppBarTheme _buildAppBarTheme(String fontFamily) => AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: variant.contrastColor,
    actionsIconTheme: IconThemeData(color: variant.primaryColor),
    titleTextStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: variant.contrastColor,
    ),
    centerTitle: false,
  );

  /// 🔘 ElevatedButton theming
  ElevatedButtonThemeData _buildElevatedButtonTheme() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: variant.primaryColor,
          foregroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: UIConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0.5,
        ),
      );

  /// 🟦 Card theming
  CardTheme _buildCardTheme() => CardTheme(
    color: variant.cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: UIConstants.commonBorderRadius,
    ),
    shadowColor: AppColors.shadow,
    elevation: 5,
  );

  /// 🧩 Easily extendable: add more `_buildXTheme()` methods to style additional widgets

  ///
}
