import 'package:flutter/material.dart';

import '_overlay_service.dart';

/// 🧩 [FocusAndOverlayDismissWrapper] — Dismisses keyboard and active overlays on tap
class FocusAndOverlayDismissWrapper extends StatelessWidget {
  final Widget child;

  const FocusAndOverlayDismissWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        OverlayNotificationService.dismissIfVisible();
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
