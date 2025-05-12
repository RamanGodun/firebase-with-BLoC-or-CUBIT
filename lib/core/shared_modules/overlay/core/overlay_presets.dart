import 'package:flutter/material.dart';

/// 🧩 [OverlayUIPresets] — Universal styling preset for overlays (banner/snackbar/dialog)
/// ✅ Extensible and composable way to define how overlays look and behave
/// ✅ Supports Open/Closed principle: base contract + optional override points
///--------------------------------------------------------------------------
sealed class OverlayUIPresets {
  const OverlayUIPresets();

  IconData get icon;
  Color get color;
  String get title;
  Duration get duration;
  EdgeInsets get margin;
  ShapeBorder get shape;
  EdgeInsets get contentPadding;
  SnackBarBehavior get behavior;
  String get confirmText;
  String? get cancelText;

  /// 🧩 Optional banner widget override
  Widget? buildBanner(String message, BuildContext context) => null;

  /// 🧩 Optional dialog widget override
  Widget? buildDialog(String title, String content, BuildContext context) =>
      null;
}

///
final class OverlayErrorPreset extends OverlayUIPresets {
  const OverlayErrorPreset();

  @override
  IconData get icon => Icons.error_outline;
  @override
  Color get color => Colors.redAccent;
  @override
  String get title => 'Помилка';
  @override
  Duration get duration => const Duration(seconds: 3);
  @override
  EdgeInsets get margin => const EdgeInsets.fromLTRB(16, 0, 16, 16);
  @override
  ShapeBorder get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
  @override
  EdgeInsets get contentPadding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  @override
  SnackBarBehavior get behavior => SnackBarBehavior.floating;
  @override
  String get confirmText => 'ОК';
  @override
  String? get cancelText => null;
}

///
final class OverlaySuccessPreset extends OverlayUIPresets {
  const OverlaySuccessPreset();

  @override
  IconData get icon => Icons.check_circle_outline;
  @override
  Color get color => Colors.green;
  @override
  String get title => 'Успішно';
  @override
  Duration get duration => const Duration(seconds: 2);
  @override
  EdgeInsets get margin => const EdgeInsets.fromLTRB(16, 0, 16, 16);
  @override
  ShapeBorder get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
  @override
  EdgeInsets get contentPadding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  @override
  SnackBarBehavior get behavior => SnackBarBehavior.fixed;
  @override
  String get confirmText => 'Гаразд';
  @override
  String? get cancelText => null;
}

///
final class OverlayInfoPreset extends OverlayUIPresets {
  const OverlayInfoPreset();

  @override
  IconData get icon => Icons.info_outline;
  @override
  Color get color => Colors.blueAccent;
  @override
  String get title => 'Інфо';
  @override
  Duration get duration => const Duration(seconds: 3);
  @override
  EdgeInsets get margin => const EdgeInsets.all(12);
  @override
  ShapeBorder get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));
  @override
  EdgeInsets get contentPadding => const EdgeInsets.all(14);
  @override
  SnackBarBehavior get behavior => SnackBarBehavior.floating;
  @override
  String get confirmText => 'Закрити';
  @override
  String? get cancelText => null;
}

///
final class OverlayWarningPreset extends OverlayUIPresets {
  const OverlayWarningPreset();

  @override
  IconData get icon => Icons.warning_amber_rounded;
  @override
  Color get color => Colors.orangeAccent;
  @override
  String get title => 'Попередження';
  @override
  Duration get duration => const Duration(seconds: 4);
  @override
  EdgeInsets get margin => const EdgeInsets.all(16);
  @override
  ShapeBorder get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
  @override
  EdgeInsets get contentPadding =>
      const EdgeInsets.symmetric(horizontal: 18, vertical: 14);
  @override
  SnackBarBehavior get behavior => SnackBarBehavior.floating;
  @override
  String get confirmText => 'Розумію';
  @override
  String? get cancelText => null;
}

///
final class OverlayConfirmPreset extends OverlayUIPresets {
  const OverlayConfirmPreset();

  @override
  IconData get icon => Icons.help_outline_rounded;
  @override
  Color get color => Colors.teal;
  @override
  String get title => 'Підтвердження';
  @override
  Duration get duration => const Duration(seconds: 0); // dialogs stay open
  @override
  EdgeInsets get margin =>
      const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
  @override
  ShapeBorder get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  @override
  EdgeInsets get contentPadding => const EdgeInsets.all(16);
  @override
  SnackBarBehavior get behavior => SnackBarBehavior.fixed;
  @override
  String get confirmText => 'Так';
  @override
  String? get cancelText => 'Ні';
}
