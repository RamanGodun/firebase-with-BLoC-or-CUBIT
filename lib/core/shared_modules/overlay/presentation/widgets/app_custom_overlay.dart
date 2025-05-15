import 'package:flutter/material.dart';

/// 🧱 [AppCustomOverlay] — Cross-platform UI wrapper for custom overlays
/// - Used by [CustomOverlayEntry] to render any custom widget
/// - Adapts styling depending on platform (iOS/macOS vs others)
///----------------------------------------------------------------------------

final class AppCustomOverlay extends StatelessWidget {
  // 🧩 Custom child widget to be displayed in the overlay
  final Widget child;
  // 📱 Target platform for platform-specific rendering
  final TargetPlatform platform;

  const AppCustomOverlay({
    super.key,
    required this.child,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return switch (platform) {
      // 🍎 iOS/macOS: translucent background with rounded corners
      TargetPlatform.iOS || TargetPlatform.macOS => _IOSStyle(child),
      // 🤖 Android/others: Material-style elevated container
      _ => _AndroidStyle(child),
    };
  }
}

/// 🍎 [_IOSStyle] — Styling for Cupertino platforms (blur-like background)
final class _IOSStyle extends StatelessWidget {
  final Widget child;
  const _IOSStyle(this.child);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: child,
      ),
    );
  }
}

/// 🤖 [_AndroidStyle] — Styling for Material-based platforms
final class _AndroidStyle extends StatelessWidget {
  final Widget child;
  const _AndroidStyle(this.child);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}
