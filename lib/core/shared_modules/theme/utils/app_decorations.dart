import 'package:flutter/material.dart' show Border, BorderSide, BoxDecoration;

import '../../../shared_layers/shared_presentation/constants/_app_constants.dart';
import '../core/app_colors.dart';

/// 🎨 [IOSBannerDecoration] — macOS/iOS-style banners with glassmorphism
/// 🍏 Includes blur, border, shadows for light/dark modes
/// ────────────────────────────────────────────────────────────────
final class IOSBannerDecoration {
  const IOSBannerDecoration._();

  static const BoxDecoration _lightThemeDecoration = BoxDecoration(
    color: AppColors.overlayLightBackground,
    borderRadius: UIConstants.commonBorderRadius,
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayLightBorder2, width: 1),
    ),
    boxShadow: AppShadows.forIOSLightThemeBanner,
  );

  static const BoxDecoration _darkThemeDecoration = BoxDecoration(
    color: AppColors.overlayDarkBackground,
    borderRadius: UIConstants.commonBorderRadius,
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayDarkBorder, width: 1),
    ),
    boxShadow: AppShadows.forIOSDarkThemeBanner,
  );

  // 📦 Memoized lookup map
  static final Map<bool, BoxDecoration> _cache = {
    false: _lightThemeDecoration,
    true: _darkThemeDecoration,
  };

  // 📦 Returns appropriate glass box based on theme brightness
  static BoxDecoration fromTheme(bool isDark) =>
      _cache[isDark] ?? (throw ArgumentError('Unknown brightness value'));
}

///

/// 🧊 [IOSDialogDecoration] — iOS/macOS style dialogs with soft glass style
/// - Used in Cupertino alert modals
/// - Memoized via internal static map
/// ────────────────────────────────────────────────────────────────
final class IOSDialogDecoration {
  const IOSDialogDecoration._();

  static const BoxDecoration _lightThemeDecoration = BoxDecoration(
    color: AppColors.overlayLightBackground4,
    borderRadius: UIConstants.commonBorderRadius,
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayLightBorder, width: 1),
    ),
    boxShadow: AppShadows.forIOSLightThemeDialog,
  );

  static const BoxDecoration _darkThemeDecoration = BoxDecoration(
    color: AppColors.overlayDarkBackground,
    borderRadius: UIConstants.commonBorderRadius,
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayDarkBorder, width: 1),
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
}

///

/// 🧱 [AndroidDialogDecorations] — Material-style overlays (Dialog, Snackbar, Banner)
/// - Consistent Material 3 appearance
/// - Memoized via internal static map
/// ────────────────────────────────────────────────────────────────
final class AndroidDialogDecorations {
  const AndroidDialogDecorations._();

  static const BoxDecoration _lightThemeDecoration = BoxDecoration(
    color: AppColors.lightSurface,
    borderRadius: UIConstants.commonBorderRadius,
    boxShadow: AppShadows.forAndroidLightThemeDialog,
  );

  static const BoxDecoration _darkThemeDecoration = BoxDecoration(
    color: AppColors.darkSurface,
    borderRadius: UIConstants.commonBorderRadius,
    boxShadow: AppShadows.forAndroidDarkThemeDialog,
  );

  // 📦 Memoized lookup map
  static final Map<bool, BoxDecoration> _cache = {
    false: _lightThemeDecoration,
    true: _darkThemeDecoration,
  };

  // 📦 Returns appropriate dialog box style
  static BoxDecoration fromTheme(bool isDark) =>
      _cache[isDark] ?? (throw ArgumentError('Unknown brightness value'));
}

///

/// 🍞 [AndroidSnackbarDecorations] — Native-like Android snackbar (Material 3)
/// - Appears at the bottom of the screen with subtle border
/// - Memoized via internal static map
/// ────────────────────────────────────────────────────────────────
final class AndroidSnackbarDecorations {
  const AndroidSnackbarDecorations._();

  static const BoxDecoration _lightThemeDecoration = BoxDecoration(
    color: AppColors.snackbarLight,
    borderRadius: UIConstants.borderRadius6,
    border: UIConstants.snackbarBorderLight,
  );

  static const BoxDecoration _darkThemeDecoration = BoxDecoration(
    color: AppColors.snackbarDark,
    borderRadius: UIConstants.borderRadius6,
    border: UIConstants.snackbarBorderDark,
  );

  // 📦 Memoized lookup map
  static final Map<bool, BoxDecoration> _cache = {
    false: _lightThemeDecoration,
    true: _darkThemeDecoration,
  };

  /// 📦 Resolved by theme
  static BoxDecoration fromTheme(bool isDark) =>
      _cache[isDark] ?? (throw ArgumentError('Unknown brightness value'));
}
