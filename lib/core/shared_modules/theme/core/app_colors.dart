import 'package:flutter/material.dart';

final class AppColors {
  const AppColors._();

  /// ────────────────────────────────────────────────────────────────────
  /// * 🎨 Colors: macOS/iOS Inspired Palette
  // ────────────────────────────────────────────────────────────────────

  /// ────────────────────────────────────────────────────────────────────
  /// 🚨 Common Colors
  // ────────────────────────────────────────────────────────────────────
  static const Color transparent = Colors.transparent;
  static const Color forErrors = Colors.redAccent;
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Colors.black;
  static const Color shadow = Color(0x33000000); // 20% black
  static const Color caption = Color(0x99000000); // approx grey.shade600
  static const Color glassCardColor = Color(0xAA222222); // Card for glass theme

  /// 🌙 Dark Theme Colors
  static const Color darkPrimary = Color.fromARGB(255, 6, 148, 132);
  static const Color darkAccent = Color.fromARGB(255, 122, 143, 116);
  static const Color darkBackground = Color(0xFF1C1C1E);
  static const Color darkSurface = Color(0xFF2C2C2E);
  static const Color darkBorder = Color(0xFF3A3A3C);
  static const Color darkOverlay = Color(0xBF1C1C1E); // 75%
  static const Color darkGlassBackground = Color(0x802C2C2E); // 50% darkSurface

  /// ☀️ Light Theme Colors
  static const Color lightPrimary = Color.fromARGB(255, 1, 81, 75);
  static const Color lightAccent = Color.fromARGB(255, 162, 196, 171);
  static const Color lightBackground = Color(0xFFF2F2F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFD6D6D6);
  static const Color lightGlassBackground = Color(0x80FFFFFF); // 50% white
  static const Color lightOverlay = Color(0xBFFFFFFF); // 75%

  /// ────────────────────────────────────────────────────────────────────
  /// 🌈 Overlay colors
  // ────────────────────────────────────────────────────────────────────

  // 🌑 DARK
  static const Color overlayDarkBackground = Color(0x661C1C1E); // 40%
  static const Color overlayDarkBorder = Color(0x1AFFFFFF); // ~10%
  static const Color overlayDarkShadow = Color(0x40000000); // 25%

  // ☀️ LIGHT
  static const Color overlayLightBackground = Color(0xB3FFFFFF); // 70%
  static const Color overlayLightBackground2 = Color(0xE6FFFFFF); // 90%
  static const Color overlayLightBackground3 = Color(0xFFF9F9F9); // 98%
  static const Color overlayLightBackground4 = Color(0xA9F6F6F6); // ≈66%
  static const Color overlayLightBorder = Color(0x1F000000); // ~12%
  static const Color overlayLightBorder2 = Color(0x0F000000); // ~6%
  static const Color overlayLightShadow = Color(0x26000000); // ~15%

  ///
  static const Color overlayDarkBarrier = Color(0x80000000); // 50% black
  static const Color overlayLightBarrier = Color(0x66D0D0D0); // 40% grey
  static const Color dividerLightOpacity = Color(0x1FFFFFFF); // 12% white
  static const Color dividerDarkOpacity = Color(0x14000000); // 8% black
  static const Color snackbarDark = Color(0xF22C2C2E); //  95%
  static const Color snackbarLight = Color(0xFAFFFFFF); //  98%
  static const Color androidDialogShadowDark = Color(0x44000000); // ~26%
  static const Color androidDialogShadowLight = Color(0x33000000); // ~20%
  static const Color overlayDarkBorder40 = Color(0x66000000); // 40%
  static const Color overlayLightBorder50 = Color(0x80000000); // 50%

  /// ────────────────────────────────────────────────────────────────────
  /// 🌈 For BUTTONS
  // ────────────────────────────────────────────────────────────────────
  static const Color primary85 = Color(0xD9005153); // 85% of primary
  static const Color primary30 = Color(0x4D005153); // 30% of primary
  static const Color buttonDisabledBackground = Color(0xFFBDBDBD); // Grey[400]
  static const Color buttonDisabledForeground = Color(0xB3FFFFFF); // White70

  ///
}
