import 'package:flutter/material.dart';
import 'enums_for_animation_module.dart';

/// 🔁 [AnimationPlatformX] — Extension to map [TargetPlatform] to [AnimationPlatform]
/// - Used by overlay system to resolve platform-specific animation behavior
extension AnimationPlatformX on TargetPlatform {
  /// Maps Flutter's [TargetPlatform] to internal [AnimationPlatform] enum
  /// - Defaults to Android for unknown platforms
  AnimationPlatform toAnimationPlatform() {
    return switch (this) {
      TargetPlatform.iOS => AnimationPlatform.ios,
      TargetPlatform.android => AnimationPlatform.android,
      _ => AnimationPlatform.android, // fallback
    };
  }
}
