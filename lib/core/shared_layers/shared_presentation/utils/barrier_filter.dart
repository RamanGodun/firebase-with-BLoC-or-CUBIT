import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared_modules/overlays/core/overlay_core_objects.dart';
import '../../../shared_modules/theme/core/app_colors.dart';

/// 🧊 [OverlayBarrierFilter] — Consistent blurred overlay backgrounds
/// - Used in: dialogs, banners, snackbars (iOS + Android)
/// - Supports [ShowAs] or override with [OverlayBlurLevel]
/// ────────────────────────────────────────────────────────────────
final class OverlayBarrierFilter {
  const OverlayBarrierFilter._();

  /// 📦 Main resolver: theme + type + optional [level] override
  static Widget resolve({
    required bool isDark,
    ShowAs? type,
    OverlayBlurLevel? level,
  }) {
    final (sigmaX, sigmaY) = switch (level) {
      OverlayBlurLevel.soft => (2.0, 2.0),
      OverlayBlurLevel.medium => (6.0, 6.0),
      OverlayBlurLevel.strong => (12.0, 12.0),
      null => _resolveSigma(type, isDark),
    };

    final color =
        isDark ? AppColors.overlayDarkBarrier : AppColors.overlayLightBarrier;

    return _build(sigmaX: sigmaX, sigmaY: sigmaY, color: color);
  }

  // ────────────────────────────────────────────────────────────────

  /// 🎚️ Theme + [ShowAs]-based blur config
  static (double, double) _resolveSigma(ShowAs? type, bool isDark) {
    return switch (type) {
      ShowAs.banner => isDark ? (12, 12) : (6, 6),
      ShowAs.dialog || ShowAs.infoDialog => isDark ? (6, 6) : (3, 3),
      ShowAs.snackbar => isDark ? (4, 4) : (2, 2),
      _ => (2.5, 2.5),
    };
  }

  /// 🔨 Widget builder
  static Widget _build({
    required double sigmaX,
    required double sigmaY,
    required Color color,
  }) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(color: color),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────

  /// ☀️ Shortcut: Light preset for dialogs
  static final Widget dialogLight = _build(
    sigmaX: 3,
    sigmaY: 3,
    color: AppColors.overlayLightBarrier,
  );

  /// 🌙 Shortcut: Dark preset for banners
  static final Widget bannerDark = _build(
    sigmaX: 12,
    sigmaY: 12,
    color: AppColors.overlayDarkBarrier,
  );
}
