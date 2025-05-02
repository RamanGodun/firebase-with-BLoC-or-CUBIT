import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 🍎 [fadeTransitionPage] — iOS-like fade animation wrapper
CustomTransitionPage<T> fadeTransitionPage<T>(Widget child) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder:
        (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
  );
}
