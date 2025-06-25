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

      ///
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: contrastColor,
        actionsIconTheme: IconThemeData(color: primaryColor),
        titleTextStyle:
            TextThemeFactory.from(colorScheme, font: font).titleSmall,
        centerTitle: false,
      ),

      ///
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary.withOpacity(
            isDark ? 0.37 : 0.72,
          ),
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: AppColors.white10,
          disabledForegroundColor: AppColors.white24,

          surfaceTintColor: AppColors.transparent,
          shadowColor: AppColors.transparent,

          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xm,
            horizontal: AppSpacing.xxxm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: UIConstants.borderRadius6,
            side: BorderSide(
              color: isDark ? AppColors.white24 : AppColors.darkBorder,
              width: isDark ? 0.05 : 0.05,
            ),
          ),
          textStyle: TextThemeFactory.from(colorScheme, font: font).titleSmall
              ?.copyWith(letterSpacing: 0.3, color: colorScheme.onPrimary),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          animationDuration: const Duration(milliseconds: 200),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          alignment: Alignment.center,
          enableFeedback: true,
        ),
      ),

      ///
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
