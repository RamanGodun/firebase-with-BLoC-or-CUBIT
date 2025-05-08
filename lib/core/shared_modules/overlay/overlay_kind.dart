import 'package:flutter/material.dart';

/// 🧩 Semantic kind types for grouped overlays
sealed class OverlayKind {
  const OverlayKind();

  IconData get icon;
  Color get color;

  static const error = _Error();
  static const success = _Success();
  static const info = _Info();
  static const warning = _Warning();
  static const confirm = _Confirm();
}

final class _Error extends OverlayKind {
  const _Error();
  @override
  IconData get icon => Icons.error_rounded;
  @override
  Color get color => Colors.redAccent;
}

final class _Success extends OverlayKind {
  const _Success();
  @override
  IconData get icon => Icons.check_circle_rounded;
  @override
  Color get color => Colors.green;
}

final class _Info extends OverlayKind {
  const _Info();
  @override
  IconData get icon => Icons.info_outline_rounded;
  @override
  Color get color => Colors.blueAccent;
}

final class _Warning extends OverlayKind {
  const _Warning();
  @override
  IconData get icon => Icons.warning_amber_rounded;
  @override
  Color get color => Colors.orangeAccent;
}

final class _Confirm extends OverlayKind {
  const _Confirm();
  @override
  IconData get icon => Icons.help_outline_rounded;
  @override
  Color get color => Colors.teal;
}
