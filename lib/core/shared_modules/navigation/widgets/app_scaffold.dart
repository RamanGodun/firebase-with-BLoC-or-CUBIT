import 'package:firebase_with_bloc_or_cubit/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/constants/_app_constants.dart';

/// 🧱 [AppScaffold] — Adaptive ShellRoute wrapper with optional glass-like background.
/// Automatically adapts background based on ThemeMode unless explicitly overridden.
base class AppScaffold extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool enableGlass;

  const AppScaffold({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.enableGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    // 🧊 Define default glass-like or solid backgrounds
    final Color defaultBackground =
        (enableGlass
            ? (isDark
                ? AppColors.darkGlassBackground
                : AppColors.lightGlassBackground)
            : (isDark ? AppColors.darkBackground : AppColors.lightBackground));

    return Scaffold(
      backgroundColor: backgroundColor ?? defaultBackground,
      body: SafeArea(
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}
