import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 🚀 [AppTransitions] — Centralized transitions for GoRouter navigation
final class AppTransitions {
  AppTransitions._();

  /// 🍎 iOS-style fade animation
  static CustomTransitionPage<T> fade<T>(Widget child) {
    return CustomTransitionPage<T>(
      child: child,
      transitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  // 📦 Ready for extension:
  // static CustomTransitionPage<T> slide<T>(Widget child) => ...
  // static CustomTransitionPage<T> scale<T>(Widget child) => ...

  ///
}
