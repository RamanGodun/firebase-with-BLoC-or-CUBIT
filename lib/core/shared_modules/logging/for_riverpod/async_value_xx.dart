// import 'package:flutter_riverpod/flutter_riverpod.dart';

// /// 📦 [AsyncValueExtensions] — Extension for `AsyncValue<T>`
// ///
// /// Adds convenient debugging and logging utilities for Riverpod async states.

// extension AsyncValueExtensions<T> on AsyncValue<T> {
//   /// 🔍 Returns a short string representation of the current `AsyncValue` state.
//   /// Useful for quick debug prints:
//   String get toStr {
//     final content = [
//       if (isLoading) 'isLoading: $isLoading',
//       if (hasValue) 'value: $valueOrNull',
//       if (hasError) 'error: $error',
//     ].join(', ');

//     return '$runtimeType($content)';
//   }

//   /// 🧪 Returns a full debug string showing all state flags and current value.
//   /// Ideal for inspecting loading, refreshing, or error transitions in providers.
//   String get props {
//     return '''
// isLoading: $isLoading, isRefreshing: $isRefreshing, isReloading: $isReloading
// hasValue: $hasValue, hasError: $hasError, value: $valueOrNull
// ''';
//   }
// }

// ///
// /// Usage:
// /// ```dart
// /// ref.watch(myAsyncProvider).toStr;
// /// ref.watch(myAsyncProvider).props;
// /// ```
