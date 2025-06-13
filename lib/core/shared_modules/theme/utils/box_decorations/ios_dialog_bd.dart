part of '_box_decorations_factory.dart';

/// 🧊 [IOSDialogsDecoration] — Cupertino-style alert/dialog box
/// 🍏 Soft glass appearance with themed border and shadow
/// Optimized for fast retrieval via theme-based caching

final class IOSDialogsDecoration {
  const IOSDialogsDecoration._();
  // ───────────────────────────

  static const BoxDecoration _lightThemeDecoration = BoxDecoration(
    color: AppColors.overlayLightBackground70,
    borderRadius: UIConstants.commonBorderRadius,
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayLightBorder12, width: 1),
    ),
    boxShadow: AppShadows.forIOSLightThemeDialog,
  );

  static const BoxDecoration _darkThemeDecoration = BoxDecoration(
    color: AppColors.overlayDarkBackground,
    borderRadius: UIConstants.commonBorderRadius,
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayDarkBorder10, width: 1),
    ),
    boxShadow: AppShadows.forIOSDarkThemeDialog,
  );

  // 📦 Memoized lookup map
  static final Map<bool, BoxDecoration> _cache = {
    false: _lightThemeDecoration,
    true: _darkThemeDecoration,
  };

  // 📦 Returns appropriate glass box for dialog
  static BoxDecoration fromTheme(bool isDark) =>
      _cache[isDark] ?? (throw ArgumentError('Unknown brightness value'));

  //
}
