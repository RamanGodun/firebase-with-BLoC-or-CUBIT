import 'package:flutter/material.dart';
import 'preset_props.dart';

/// 🧩 [OverlayUIPresets] — Abstract base for defining UI style presets
/// - Returns [OverlayUIPresetProps] for overlays (e.g. snackbars, banners)
/// - Immutable and memoized for performance
/// - Supports `.withOverride()` to customize existing presets
///----------------------------------------------------------------------------

sealed class OverlayUIPresets {
  const OverlayUIPresets();

  /// 🎨 Resolves the current preset to styling props
  OverlayUIPresetProps resolve();

  /// 🧪 Creates a new customized preset by overriding selected fields
  OverlayUIPresets withOverride({
    IconData? icon,
    Color? color,
    Duration? duration,
    EdgeInsets? margin,
    ShapeBorder? shape,
    EdgeInsets? contentPadding,
    SnackBarBehavior? behavior,
  }) {
    return _OverlayCustomPreset(
      resolve().copyWith(
        icon: icon,
        color: color,
        duration: duration,
        margin: margin,
        shape: shape,
        contentPadding: contentPadding,
        behavior: behavior,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ✅ Built-in Presets (Memoized)
// ─────────────────────────────────────────────────────────────────────────────

/// ℹ️ [OverlayInfoUIPreset] — Blue info-style banner/snackbar
final class OverlayInfoUIPreset extends OverlayUIPresets {
  const OverlayInfoUIPreset();

  static final OverlayUIPresetProps _resolved = const OverlayUIPresetProps(
    icon: Icons.info_outline,
    color: Colors.blueAccent,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    contentPadding: EdgeInsets.all(14),
    behavior: SnackBarBehavior.floating,
  );

  @override
  OverlayUIPresetProps resolve() => _resolved;
}

/// ❌ [OverlayErrorUIPreset] — Red error-style preset
final class OverlayErrorUIPreset extends OverlayUIPresets {
  const OverlayErrorUIPreset();

  static final _resolved = const OverlayUIPresetProps(
    icon: Icons.error_outline,
    color: Colors.redAccent,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    behavior: SnackBarBehavior.floating,
  );

  @override
  OverlayUIPresetProps resolve() => _resolved;
}

/// ✅ [OverlaySuccessUIPreset] — Green success confirmation preset
final class OverlaySuccessUIPreset extends OverlayUIPresets {
  const OverlaySuccessUIPreset();

  static final _resolved = const OverlayUIPresetProps(
    icon: Icons.check_circle_outline,
    color: Colors.green,
    duration: Duration(seconds: 2),
    margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    behavior: SnackBarBehavior.fixed,
  );

  @override
  OverlayUIPresetProps resolve() => _resolved;
}

/// ⚠️ [OverlayWarningUIPreset] — Orange warning preset
final class OverlayWarningUIPreset extends OverlayUIPresets {
  const OverlayWarningUIPreset();

  static final _resolved = const OverlayUIPresetProps(
    icon: Icons.warning_amber_rounded,
    color: Colors.orangeAccent,
    duration: Duration(seconds: 4),
    margin: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    behavior: SnackBarBehavior.floating,
  );

  @override
  OverlayUIPresetProps resolve() => _resolved;
}

/// ❓ [OverlayConfirmUIPreset] — Used for confirm dialogs (duration = 0)
final class OverlayConfirmUIPreset extends OverlayUIPresets {
  const OverlayConfirmUIPreset();

  static final _resolved = const OverlayUIPresetProps(
    icon: Icons.help_outline_rounded,
    color: Colors.teal,
    duration: Duration.zero,
    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: EdgeInsets.all(16),
    behavior: SnackBarBehavior.fixed,
  );

  @override
  OverlayUIPresetProps resolve() => _resolved;
}

/// 🧪 [_OverlayCustomPreset] — Internal: Used to hold customized resolved props
final class _OverlayCustomPreset extends OverlayUIPresets {
  final OverlayUIPresetProps _props;

  const _OverlayCustomPreset(this._props);

  @override
  OverlayUIPresetProps resolve() => _props;
}
