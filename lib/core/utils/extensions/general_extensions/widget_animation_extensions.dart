part of '_general_extensions.dart';

extension AnimateX on Widget {
  Widget fadeIn({Duration duration = const Duration(milliseconds: 400)}) =>
      AnimatedOpacity(opacity: 1, duration: duration, child: this);
}
