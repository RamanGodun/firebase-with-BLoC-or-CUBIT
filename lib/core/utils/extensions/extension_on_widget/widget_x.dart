part of '_widget_x.dart';



/// 👁️ [WidgetVisibilityX] — Hides widget conditionally (used for UI logic)
//----------------------------------------------------------------

extension WidgetVisibilityX on Widget {
  /// 🧱 Returns [SizedBox.shrink] if `shouldHide` is true
  Widget hide(bool shouldHide) => shouldHide ? const SizedBox.shrink() : this;
}

/// 👆 [TapX] — Adds `onTap` behavior to any widget
/// ✅ Adds transparent hit detection for better UX
//----------------------------------------------------------------

extension TapX on Widget {
  /// 🖱️ Wraps widget in [GestureDetector] with opaque hit target
  Widget onTap(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}
