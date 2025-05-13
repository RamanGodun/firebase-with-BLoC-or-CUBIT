import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// 📦 Props — Pure UI styling configuration
// ─────────────────────────────────────────────────────────────────────────────

class OverlayUIPresetProps extends Equatable {
  final IconData icon;
  final Color color;
  final Duration duration;
  final EdgeInsets margin;
  final ShapeBorder shape;
  final EdgeInsets contentPadding;
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

  ///
}
