import 'package:flutter/material.dart';

/// 🧱 [AppCustomOverlay] — Cross-platform UI wrapper for custom overlays
class AppCustomOverlay extends StatelessWidget {
  final Widget child;
  final TargetPlatform platform;

  const AppCustomOverlay({
    super.key,
    required this.child,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return switch (platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => _IOSStyle(child),
      _ => _AndroidStyle(child),
    };
  }
}

class _IOSStyle extends StatelessWidget {
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

class _AndroidStyle extends StatelessWidget {
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
