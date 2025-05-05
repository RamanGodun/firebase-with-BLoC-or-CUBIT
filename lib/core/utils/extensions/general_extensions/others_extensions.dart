part of '_general_extensions.dart';

extension WidgetVisibilityX on Widget {
  Widget hide(bool shouldHide) => shouldHide ? const SizedBox.shrink() : this;
}

extension TapX on Widget {
  Widget onTap(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}

extension WidgetAlignX on Widget {
  Widget aligned(Alignment alignment) =>
      Align(alignment: alignment, child: this);

  Widget centered() => Center(child: this);
  Widget centerLeft() => aligned(Alignment.centerLeft);
  Widget centerRight() => aligned(Alignment.centerRight);
  Widget topCenter() => aligned(Alignment.topCenter);
  Widget bottomCenter() => aligned(Alignment.bottomCenter);
}
