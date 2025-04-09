import 'dart:async';

/// ⏱️ [Debouncer] — utility for delaying execution after user stops typing/tapping/etc.
/// Commonly used for:
///   • Search fields
///   • Input validation
///   • Rate-limiting expensive operations
class Debouncer {
  final Duration duration;
  Timer? _timer;

  /// 🔧 Create a new [Debouncer] with custom duration
  Debouncer(this.duration);

  /// 🚀 Run an action after a pause (previous calls cancel pending one)
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// 🧹 Cancel any pending action (optional)
  void cancel() => _timer?.cancel();
}
