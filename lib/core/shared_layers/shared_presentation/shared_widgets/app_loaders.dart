import 'package:firebase_with_bloc_or_cubit/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../general_utils/extensions/extension_on_widget/_widget_x.dart';

/// 🔄 [LoaderWidget] — Flexible root-level loader, used for:
/// - showing loader during bootstrap (wrapInMaterialApp = true)
/// - loading states in UI (wrapInMaterialApp = false)
//---------------------------------------------------

final class LoaderWidget extends StatelessWidget {
  final bool wrapInMaterialApp;
  final TargetPlatform? platformOverride;
  final Color? backgroundColor;

  const LoaderWidget({
    super.key,
    this.wrapInMaterialApp = false,
    this.platformOverride,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final loader = AppLoader(
      platformOverride: platformOverride,
      backgroundColor: backgroundColor,
    );

    return wrapInMaterialApp
        ? LoaderAppShell(child: loader)
        : Material(type: MaterialType.transparency, child: loader);
  }
}

/// 🧱 Shell for displaying loader before actual [MaterialApp] loads.
final class LoaderAppShell extends StatelessWidget {
  final Widget child;
  const LoaderAppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) => MaterialApp(home: child);
}

/// 🔄 Adaptive loader with styled platform visuals
final class AppLoader extends StatelessWidget {
  final TargetPlatform? platformOverride;
  final Color? backgroundColor;

  const AppLoader({super.key, this.platformOverride, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final platform = platformOverride ?? context.platform;
    final color =
        backgroundColor ?? context.colorScheme.secondary.withOpacity(0.1);

    return switch (platform) {
      TargetPlatform.android => _LoaderContainerWidget(
        shape: BoxShape.circle,
        color: color,
        shadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
        padding: const EdgeInsets.all(16),
        child: const CircularProgressIndicator(),
      ),
      TargetPlatform.iOS => _LoaderContainerWidget(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: color,
        size: const Size(64, 64),
        child: const CircularProgressIndicator.adaptive(),
      ),
      _ => const CircularProgressIndicator.adaptive().centered(),
    };
  }
}

/// 🧱 [_LoaderContainerWidget] — Visual container for loader content.
/// Supports flexible layout for Android / iOS styles.
final class _LoaderContainerWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;
  final EdgeInsetsGeometry padding;
  final Size? size;

  const _LoaderContainerWidget({
    required this.child,
    required this.color,
    required this.shape,
    this.borderRadius,
    this.shadow,
    this.padding = const EdgeInsets.all(16),
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size?.width,
        height: size?.height,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          shape: shape,
          borderRadius: borderRadius,
          boxShadow: shadow,
        ),
        child: child,
      ),
    );
  }
}
