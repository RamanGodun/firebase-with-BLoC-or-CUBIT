import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// 🎨 [OverlayUIPresetProps] — Pure styling config for overlay UI
/// - Immutable value object used in preset resolution
/// - Passed to UI widgets (e.g. [AppBanner], [AppSnackbarWidget])
/// - Encapsulates color, shape, icon, spacing, duration, etc.

@immutable
final class OverlayUIPresetProps extends Equatable {
  ///--------------------------------------------

  ///🧩 Leading icon for the overlay
  final IconData icon;
  // 🎨 Background color
  final Color color;
  // ⏱️ Duration the overlay remains on screen
  final Duration duration;
  // ↔️ Outer margin from screen edges
  final EdgeInsets margin;
  // 🪟 Shape of the card/dialog/snackbar
  final ShapeBorder shape;
  // 🧃 Padding inside the content area
  final EdgeInsets contentPadding;
  // 🧭 SnackBar behavior (fixed/floating)
  final SnackBarBehavior behavior;

  const OverlayUIPresetProps({
    required this.icon,
    required this.color,
    required this.duration,
    required this.margin,
    required this.shape,
    required this.contentPadding,
    required this.behavior,
  });

  /// 🔁 Creates a new copy with optional overrides
  OverlayUIPresetProps copyWith({
    IconData? icon,
    Color? color,
    Duration? duration,
    EdgeInsets? margin,
    ShapeBorder? shape,
    EdgeInsets? contentPadding,
    SnackBarBehavior? behavior,
  }) {
    return OverlayUIPresetProps(
      icon: icon ?? this.icon,
      color: color ?? this.color,
      duration: duration ?? this.duration,
      margin: margin ?? this.margin,
      shape: shape ?? this.shape,
      contentPadding: contentPadding ?? this.contentPadding,
      behavior: behavior ?? this.behavior,
    );
  }

  @override
  List<Object> get props => [
    icon,
    color,
    duration,
    margin,
    shape,
    contentPadding,
    behavior,
  ];

  //
}
