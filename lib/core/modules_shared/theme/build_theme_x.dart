part of 'app_theme_variants.dart';

// 🎨 Enhanced enum for ThemeType
extension ThemeVariantX on ThemeVariantsEnum {
  ///----------------------------------

  ///
  ThemeData build({AppFontFamily? font}) {
    ///
    //
    return ThemeData(
      //
      brightness: brightness,
      scaffoldBackgroundColor: background,
      primaryColor: primaryColor,
      colorScheme: colorScheme,

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: contrastColor,
        actionsIconTheme: IconThemeData(color: primaryColor),
        titleTextStyle:
            TextThemeFactory.from(colorScheme, font: font).titleSmall,
        centerTitle: false,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: UIConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xm,
            horizontal: AppSpacing.xxxm,
          ),
          elevation: 0.5,
        ),
      ),

      cardTheme: CardThemeData(
        color: cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: UIConstants.commonBorderRadius,
        ),
        shadowColor: AppColors.shadow,
        elevation: 1,
      ),

      textTheme: TextThemeFactory.from(colorScheme, font: font),

      //
    );
  }

  //
}
