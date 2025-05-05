part of '_app_constants.dart';

class AppColors {
  /// ────────────────────────────────────────────────────────────────────
  /// * 🎨 Colors: macOS/iOS Inspired Palette
  // ────────────────────────────────────────────────────────────────────

  /// ────────────────────────────────────────────────────────────────────
  /// 🚨 Common Colors
  // ────────────────────────────────────────────────────────────────────
  static const Color forErrors = Colors.redAccent;
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Colors.black;
  static const Color shadow = Color(0x33000000); // 20% black
  static const Color caption = Color(0x99000000); // approx grey.shade600

  /// 🌙 Dark Theme Colors
  static const Color darkPrimary = Color.fromARGB(255, 6, 148, 132);
  static const Color darkAccent = Color.fromARGB(255, 122, 143, 116);
  static const Color darkBackground = Color(0xFF1C1C1E);
  static const Color darkSurface = Color(0xFF2C2C2E);
  static const Color darkOverlay = Color(0xBF1C1C1E); // 75% opacity
  static const Color darkBorder = Color(0xFF3A3A3C);
  static const Color darkGlassBackground = Color(0x802C2C2E); // 50% darkSurface

  /// ☀️ Light Theme Colors
  static const Color lightPrimary = Color.fromARGB(255, 1, 81, 75);
  static const Color lightAccent = Color.fromARGB(255, 162, 196, 171);
  static const Color lightBackground = Color(0xFFF2F2F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOverlay = Color(0xBFFFFFFF); // 75% opacity
  static const Color lightBorder = Color(0xFFD6D6D6);
  static const Color lightGlassBackground = Color(0x80FFFFFF); // 50% white

  /// ────────────────────────────────────────────────────────────────────
  /// 🌈 Overlay colors
  // ────────────────────────────────────────────────────────────────────
  static const Color overlayDarkBorder = Color(0xFF2C2C2E);
  static const Color overlayLightBorder = Color(0xFFD6D6D6);

  /// ────────────────────────────────────────────────────────────────────
  /// 🌈 For BUTTONS
  // ────────────────────────────────────────────────────────────────────
  ///
  static const Color primary85 = Color(0xD9005153); // 85% of primary
  static const Color primary30 = Color(0x4D005153); // 30% of primary
  ///
}
