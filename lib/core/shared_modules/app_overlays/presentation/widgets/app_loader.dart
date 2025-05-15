import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';

/// 🔄 [AppLoader] — Platform-adaptive loading spinner
/// - Renders circular loader with styled background
/// - Uses custom decoration on Android/iOS, fallback adaptive loader elsewhere
/// - Used by [LoaderOverlayEntry] as final visual widget
///----------------------------------------------------------------------------

final class AppLoader extends StatelessWidget {
  // 📱 Target platform to determine visual styling
  final TargetPlatform? platformOverride;

  const AppLoader({this.platformOverride, super.key});

  @override
  Widget build(BuildContext context) {
    final platform = platformOverride ?? context.platform;

    return switch (platform) {
      //
      // 🤖 Android: loader inside circular background with shadow
      TargetPlatform.android => Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.secondary.withOpacity(0.1),
            shape: BoxShape.circle,
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: const CircularProgressIndicator(),
        ),
      ),

      // 🍎 iOS: loader inside rounded rectangle
      TargetPlatform.iOS => Center(
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: context.colorScheme.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),

      // 🖥️ Other platforms: default adaptive loader centered
      _ => const CircularProgressIndicator.adaptive().centered(),
    };
  }
}
