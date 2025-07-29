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

          disabledBackgroundColor:
              isDark ? AppColors.white10 : AppColors.black12,

          disabledForegroundColor: AppColors.black12,
          surfaceTintColor: AppColors.transparent,
          shadowColor: AppColors.shadow,

          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xm,
            horizontal: AppSpacing.xxxm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: UIConstants.borderRadius8,
            side: BorderSide(
              color: isDark ? AppColors.black5 : AppColors.darkBorder,
              width: isDark ? 0.05 : 0.05,
            ),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          animationDuration: AppDurations.ms250,
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
