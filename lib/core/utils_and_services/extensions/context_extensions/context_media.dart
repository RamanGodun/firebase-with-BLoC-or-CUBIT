part of '_context_extensions.dart';

/// 📏 [ContextMediaX] — MediaQuery & screen size extensions
extension ContextMediaX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  bool get isTablet => mediaQuery.size.shortestSide >= 600;
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get textScale => mediaQuery.textScaleFactor;
  double get pixelRatio => mediaQuery.devicePixelRatio;
}
