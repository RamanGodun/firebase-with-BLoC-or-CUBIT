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
