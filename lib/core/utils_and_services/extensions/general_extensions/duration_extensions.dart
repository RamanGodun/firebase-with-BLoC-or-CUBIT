part of '_general_extensions.dart';

extension DurationX on Duration {
  String formatAsTimer() {
    final mins = inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }
}
