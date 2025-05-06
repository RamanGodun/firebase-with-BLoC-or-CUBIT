import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';

import '_overlay_service.dart';

/// 🧩 [FocusAndOverlayDismissWrapper] – Wrapper widget that:
/// - 📱 Dismisses soft keyboard
/// - 🔕 Hides active floating overlays (e.g., toast banners)
/// 👉 Use to wrap full screens or forms to improve UX when tapping outside input
//----------------------------------------------------------------

class FocusAndOverlayDismissWrapper extends StatelessWidget {
  final Widget child;
  const FocusAndOverlayDismissWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 🔕 Hide keyboard & overlays
        context.unfocusKeyboard();
        OverlayNotificationService.dismissIfVisible();
      },
      behavior: HitTestBehavior.translucent, // 📍 Allows tap on empty space
      child: child,
    );
  }
}
