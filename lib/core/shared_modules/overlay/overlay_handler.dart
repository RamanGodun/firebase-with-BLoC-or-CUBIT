import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';

import 'dispatcher.dart';

/// 🧩 [GlobalOverlayHandler] – Universal wrapper for:
/// - 📱 Dismissing keyboard
/// - 🔕 Hiding active floating overlays/notifications (e.g., toast banners)
/// 👉 Use to wrap full screens or forms to improve UX when tapping outside input
//----------------------------------------------------------------

final class GlobalOverlayHandler extends StatelessWidget {
  final Widget child;

  /// Whether to dismiss keyboard on tap (default: true)
  final bool dismissKeyboard;

  /// Whether to dismiss overlay notification on tap (default: true)
  final bool dismissOverlay;

  const GlobalOverlayHandler({
    super.key,
    required this.child,
    this.dismissKeyboard = true,
    this.dismissOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (dismissKeyboard) context.unfocusKeyboard();
        if (dismissOverlay) OverlayDispatcher.instance.dismissCurrent();
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
