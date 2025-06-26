// 📁 core/widgets_shared/animation/animated_switcher_wrapper.dart

import 'package:flutter/material.dart';

class AnimatedSwitcherWrapper extends StatelessWidget {
  final Widget child;
  const AnimatedSwitcherWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        layoutBuilder:
            (currentChild, previousChildren) => Stack(
              alignment: Alignment.center,
              children: [
                if (currentChild != null) currentChild,
                ...previousChildren,
              ],
            ),
        transitionBuilder:
            (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
        child: child,
      ),
    );
  }
}
