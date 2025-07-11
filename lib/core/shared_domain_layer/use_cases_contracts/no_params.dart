import 'package:flutter/foundation.dart';

/// 🧩 [NoParams] — Empty object for use-cases without input
/// ✅ Used to comply with generic [UseCaseWithParams] signature

@immutable
final class NoParams {
  ///----------------
  const NoParams._();

  ///
  static const instance = NoParams._();
  //
}
