part of '_app_constants.dart';

abstract final class AppShadows {
  ///----------------------------
  const AppShadows._();
  //

  /// 🍏 Dialog-specific shadows
  static const List<BoxShadow> forIOSLightThemeDialog = [
    BoxShadow(
      color: AppColors.overlayLightShadow,
      blurRadius: 12,
      spreadRadius: 0.4,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> forIOSDarkThemeDialog = [
    BoxShadow(
      color: AppColors.overlayDarkShadow,
      blurRadius: 12,
      spreadRadius: 0.4,
      offset: Offset(0, 3),
    ),
  ];

  /// 📦 Shadows for Android dialog
  static const List<BoxShadow> forAndroidDarkThemeDialog = [
    BoxShadow(
      color: AppColors.androidDialogShadowDark,
      blurRadius: 14,
      spreadRadius: 0.2,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> forAndroidLightThemeDialog = [
    BoxShadow(
      color: AppColors.androidDialogShadowLight,
      blurRadius: 10,
      spreadRadius: 0.1,
      offset: Offset(0, 3),
    ),
  ];

  /// 🍏 Card-specific shadows
  static const List<BoxShadow> forLightThemeCard = [
    BoxShadow(
      color: AppColors.overlayLightShadow,
      blurRadius: 8,
      spreadRadius: 0.5,
      offset: Offset(0, 3),
    ),
  ];

  static const List<BoxShadow> forDarkThemeCard = [
    BoxShadow(
      color: AppColors.overlayDarkShadow,
      blurRadius: 18,
      spreadRadius: 0.5,
      offset: Offset(0, 3),
    ),
  ];

  //
}
