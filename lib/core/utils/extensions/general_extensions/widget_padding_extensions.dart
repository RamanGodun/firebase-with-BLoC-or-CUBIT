part of '_general_extensions.dart';

extension WidgetPaddingX on Widget {
  Widget withPaddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget withPaddingSymmetric({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );

  Widget withPaddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  Widget withPaddingHorizontal(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  Widget withPaddingVertical(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  Widget withPaddingTop(double value) =>
      Padding(padding: EdgeInsets.only(top: value), child: this);

  Widget withPaddingBottom(double value) =>
      Padding(padding: EdgeInsets.only(bottom: value), child: this);

  Widget withPaddingLeft(double value) =>
      Padding(padding: EdgeInsets.only(left: value), child: this);

  Widget withPaddingRight(double value) =>
      Padding(padding: EdgeInsets.only(right: value), child: this);
}
