import 'package:flutter/material.dart';

import '../animation_engines/_animation_engine_factory.dart';

extension AnimationPlatformX on TargetPlatform {
  AnimationPlatform toAnimationPlatform() {
    return switch (this) {
      TargetPlatform.iOS => AnimationPlatform.ios,
      TargetPlatform.android => AnimationPlatform.android,
      _ => AnimationPlatform.android, // fallback
    };
  }
}
