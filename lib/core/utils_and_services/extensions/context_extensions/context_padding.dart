part of '_context_extensions.dart';

/// 📐 [ContextPaddingX] — Safe area and insets extensions
extension ContextPaddingX on BuildContext {
  double get topPadding => mediaQuery.padding.top;
  double get bottomPadding => mediaQuery.padding.bottom;
  double get horizontalPadding =>
      mediaQuery.padding.left + mediaQuery.padding.right;
  double get verticalPadding =>
      mediaQuery.padding.top + mediaQuery.padding.bottom;
}
