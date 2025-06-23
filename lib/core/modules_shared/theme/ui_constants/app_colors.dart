import 'package:flutter/material.dart' show Color, Colors;

final class AppColors {
  ///------------------
  const AppColors._();
  //

  /// ────────────────────
  /// 🚨 Common Colors
  // ─────────────────────
  static const Color transparent = Colors.transparent;
  static const Color forErrors = Color(0xFFFF5252); // redAccent
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color shadow = Color(0x33000000); // 20% black
  static const Color caption = Color(0x99000000); // approx grey.shade600
  static const Color glassCard = Color(0xAA222222); // Card for glass theme

  /// 🌙 Dark Theme Colors
  static const Color darkPrimary = Color(0xFF069484);
  static const Color darkAccent = Color(0xFF7A8F74);
  static const Color darkBackground = Color(0xFF1C1C1E);
  static const Color darkSurface = Color(0xFF2C2C2E);
  static const Color darkBorder = Color(0xFF3A3A3C);
  static const Color darkCard = Color(0xFF2C2C2E);
  static const Color darkGlassBackground = Color(0x802C2C2E); // 50% darkSurface

  /// ☀️ Light Theme Colors
  static const Color lightPrimary = Color(0xFF01514B);
  static const Color lightAccent = Color(0xFFA2C4AB);
  static const Color lightBackground = Color(0xFFF2F2F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFD6D6D6);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightGlassBackground = Color(0x80FFFFFF); // 50% white

  /// ──────────────────
  /// 🌈 Overlay colors
  // ───────────────────

  // 🌑 DARK
  static const Color darkOverlay = Color(0xBF1C1C1E); // 75%
  static const Color overlayDarkBackground = Color(0x661C1C1E); // 40%
  static const Color overlayDarkBorder10 = Color(0x1AFFFFFF); // ~10%
  static const Color overlayDarkBorder40 = Color(0x66000000); // 40%
  static const Color overlayDarkShadow = Color(0x40000000); // 25%
  static const Color overlayDarkBarrier = Color(0x80000000); // 50% black
  static const Color dividerDarkOpacity = Color(0x14000000); // 8% black
  static const Color snackbarDark = Color(0xF22C2C2E); //  95%
  static const Color androidDialogShadowDark = Color(0x44000000); // ~26%

  // ☀️ LIGHT
  static const Color lightOverlay = Color(0xBFFFFFFF); // 75%
  static const Color overlayLightBackground70 = Color(0xB3FFFFFF); // 70%
  static const Color overlayLightBackground90 = Color(0xE6FFFFFF); // 90%
  static const Color overlayLightBorder12 = Color(0x1F000000); // ~12%
  static const Color overlayLightBorder50 = Color(0x80000000); // 50%
  static const Color overlayLightShadow = Color(0x26000000); // ~15%s
  static const Color overlayLightBarrier = Color(0x66D0D0D0); // 40% grey
  static const Color dividerLightOpacity = Color(0x1FFFFFFF); // 12% white
  static const Color snackbarLight = Color(0xFAFFFFFF); //  98%
  static const Color androidDialogShadowLight = Color(0x33000000); // ~20%

  /// ───────────────
  /// BUTTON COLORS
  // ────────────────
  static const Color primary85 = Color(0xD9005153);
  static const Color primary30 = Color(0x4D005153);
  static const Color buttonDisabledBackground = Color(0xFFBDBDBD);
  static const Color buttonDisabledForeground = Color(0xB3FFFFFF);

  ///

  //
}
