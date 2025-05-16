import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../app_animation/banner_host.dart';
import '../presentation/overlay_presets/preset_props.dart';
import '../presentation/widgets/app_dialog.dart';
import '../presentation/widgets/app_snackbar.dart';

final class OverlayService {
  const OverlayService._();

  static OverlayEntry? _activeBanner;

  /// 🪧 Shows a lightweight floating banner. Replaces previous if visible.
  static void showBanner(BuildContext context, String message, IconData icon) {
    _activeBanner?.remove();

    final entry = OverlayEntry(
      builder: (_) => OverlayBannerHost(message: message, icon: icon),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Overlay.of(context, rootOverlay: true);
      overlay.insert(entry);
      _activeBanner = entry;

      Future.delayed(const Duration(seconds: 2), () {
        _activeBanner?.remove();
        _activeBanner = null;
      });
    });
  }

  /// 💬 Shows a platform-adaptive dialog (Material/Cupertino)
  static Future<void> showAppDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresetProps? presetProps,
    TargetPlatform? platform,
    bool isInfoDialog = false,
  }) {
    return showDialog(
      context: context,
      builder:
          (_) => AppDialog(
            title: title,
            content: content,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
            presetProps: presetProps,
            platform: platform ?? context.platform,
            isInfoDialog: isInfoDialog,
          ),
    );
  }

  /// 🍞 Shows a platform-aware snackbar at the bottom
  static void showSnackbar(
    BuildContext context, {
    required String message,
    required IconData icon,
    OverlayUIPresetProps? presetProps,
    TargetPlatform? platform,
  }) {
    final props =
        presetProps ??
        const OverlayUIPresetProps(
          icon: Icons.info,
          color: Colors.black87,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          contentPadding: EdgeInsets.all(14),
          behavior: SnackBarBehavior.floating,
        );

    final entry = OverlayEntry(
      builder:
          (_) => AppSnackbarWidget(
            message: message,
            icon: icon,
            props: props,
            platform: platform ?? context.platform,
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(entry);

    Future.delayed(props.duration, () => entry.remove());
  }

  ///
}
