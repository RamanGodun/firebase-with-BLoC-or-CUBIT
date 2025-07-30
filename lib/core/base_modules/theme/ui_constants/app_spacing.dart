part of '_app_constants.dart';

/// 📏 [AppSpacing] — Centralized collection of spacing constants for layout.
///   Use these for all paddings, margins, gaps, and geometry in your app,
///   to ensure a consistent and visually balanced design system.
///   Grouped by semantic sizing: tiny → small → medium → large → extra large.
///   Always use these constants for layout instead of hardcoded numbers.
//
abstract final class AppSpacing {
  ///-------------------------
  const AppSpacing._();

  /// No space (used to explicitly reset padding/margin)
  static const double zero = 0.0;

  /// ───── Tiny / Small values ─────
  static const double s = 2.0;
  static const double xs = 4.0;
  static const double xxs = 6.0;
  static const double xxxs = 8.0;

  /// ───── Medium values ─────
  static const double m = 10.0;
  static const double xm = 12.0;
  static const double xxm = 15.0;
  static const double xxxm = 18.0;

  /// ───── Large values ─────
  static const double l = 30.0;
  static const double xl = 40.0;
  static const double xxl = 50.0;
  static const double xxxl = 65.0;
  static const double xxxxl = 85.0;

  /// ───── Special large values ─────
  static const double huge = 100.0;
  static const double massive = 120.0;

  /// ───── Utility/pixel-specific values (for precise control) ─────
  static const double p7 = 7.0;
  static const double p10 = 10.0;
  static const double p16 = 16.0;
  static const double p26 = 26.0;

  //
}
