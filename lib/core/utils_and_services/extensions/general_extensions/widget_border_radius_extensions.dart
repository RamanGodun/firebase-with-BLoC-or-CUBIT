part of '_general_extensions.dart';

extension BorderRadiusX on Widget {
  Widget withRoundedCorners([double r = 12]) =>
      ClipRRect(borderRadius: BorderRadius.circular(r), child: this);
}
