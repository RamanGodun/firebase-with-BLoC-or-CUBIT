part of '_context_extensions.dart';

/// 📏 [ContextMediaX] — MediaQuery-based extensions for screen sizing & scaling
/// ✅ Provides shorthand access to screen dimensions, padding, and scale factors
//----------------------------------------------------------------

extension ContextMediaX on BuildContext {
  /// 📐 Full [MediaQueryData]
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// ↔️ Screen width
  double get screenWidth => mediaQuery.size.width;

  /// ↕️ Screen height
  double get screenHeight => mediaQuery.size.height;

  /// 📐 Raw size
  Size get size => mediaQuery.size;

  /// ⬅️➡️ Alias for [screenWidth]
  double get width => size.width;

  /// ⬆️⬇️ Alias for [screenHeight]
  double get height => size.height;

  /// 📱 Checks if device is a tablet (shortest side ≥ 600dp)
  bool get isTablet => mediaQuery.size.shortestSide >= 600;

  /// 🔤 Text scale factor (for accessibility)
  double get textScale => mediaQuery.textScaleFactor;

  /// 🧪 Screen pixel density
  double get pixelRatio => mediaQuery.devicePixelRatio;

  /// 📐 Top safe area inset (e.g. notch)
  double get topPadding => mediaQuery.padding.top;

  /// 📐 Bottom safe area inset (e.g. home indicator)
  double get bottomPadding => mediaQuery.padding.bottom;

  /// 📐 Combined horizontal safe padding (left + right)
  double get horizontalPadding =>
      mediaQuery.padding.left + mediaQuery.padding.right;

  /// 📐 Combined vertical safe padding (top + bottom)
  double get verticalPadding =>
      mediaQuery.padding.top + mediaQuery.padding.bottom;

  ///
}
