import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/new_engines/context_x_for_engines.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '../../app_animation/animated_overlay_wrapper.dart';
import '../../app_errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import '../core/overlay_enums.dart';
import 'conflicts_strategy/police_resolver.dart';
import 'platform_mapper.dart';
import 'overlay_entries/_overlay_entries.dart';
import '../presentation/overlay_presets/overlay_presets.dart';
import 'overlay_dispatcher/overlay_dispatcher_interface.dart';

/// 🎯 [ContextXForStateDrivenOverlayFlow] — Unified extension for overlay DSL and dispatcher access
/// ✅ Use `context.showSnackbar(...)` / `context.showBanner(...)` directly
/// ✅ No need to use intermediate `OverlayController`
//-------------------------------------------------------------

extension ContextXForStateDrivenOverlayFlow on BuildContext {
  //
  /// 🔌 Direct access to [IOverlayDispatcher] from DI
  IOverlayDispatcher get overlayDispatcher => di<IOverlayDispatcher>();
  //

  /// 💬 Shows a short platform-adaptive dialog (iOS/Android)
  void showDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
    bool isInfoDialog = false,
    Duration autoDismissDuration = Duration.zero,
  }) {
    //
    final engine = getEngine(OverlayCategory.dialog);

    //
    final dialogWidget = PlatformMapper.resolveAppDialog(
      platform: platform,
      engine: engine,
      title: title,
      content: content,
      confirmText: confirmText ?? 'OK',
      cancelText: cancelText ?? 'Cancel',
      onConfirm: onConfirm,
      onCancel: onCancel,
      presetProps: preset.resolve(),
      isInfoDialog: isInfoDialog,
      isFromUserFlow: false,
    );

    // 🎬 Wraps with [AnimatedOverlayWrapper] that controls lifecycle and animation
    final animatedDialog = AnimatedOverlayWrapper(
      engine: engine,
      displayDuration: autoDismissDuration,
      builder: (_) => dialogWidget,
    );

    ///
    final entry = DialogOverlayEntry(
      widget: animatedDialog,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
      isError: isError,
    );

    overlayDispatcher.enqueueRequest(this, entry);
  }

  ///

  /// 🪧 Shows a platform-aware banner (iOS/Android) using optional preset
  // void showBanner({
  //   required String message,
  //   IconData? icon,
  //   OverlayUIPresets preset = const OverlayInfoUIPreset(),
  //   bool isError = false,
  //   bool isDismissible = true,
  // }) {
  //   final entry = BannerOverlayEntry(
  //     message,
  //     preset: preset,
  //     isError: isError,
  //     icon: icon,
  //     dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
  //   );
  //   overlayDispatcher.enqueueRequest(this, entry);
  // }

  /// 🍞 Shows a platform-aware snackbar (iOS/Android) using optional preset
  // void showSnackbar({
  //   required String message,
  //   OverlayUIPresets preset = const OverlayInfoUIPreset(),
  //   bool isError = false,
  //   IconData? icon,
  //   bool isDismissible = true,
  // }) {
  //   final entry = SnackbarOverlayEntry(
  //     message,
  //     preset: preset,
  //     isError: isError,
  //     icon: icon,
  //     dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
  //   );
  //   overlayDispatcher.enqueueRequest(this, entry);
  // }

  /// 🧠 Handles displaying [FailureUIModel] as banner/snackbar/dialog
  /// 📌 Uses [OverlayUIPresets] and [ShowErrorAs] to configure appearance and behavior
  void showError(
    FailureUIModel model, {
    ShowErrorAs showAs = ShowErrorAs.infoDialog,
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
    bool isDismissible = false,
  }) {
    ///

    switch (showAs) {
      //
      // case ShowErrorAs.banner:
      //   showBanner(
      //     message: model.localizedMessage,
      //     icon: model.icon,
      //     preset: preset,
      //     isError: true,
      //     isDismissible: isDismissible,
      //   );
      //   break;
      // //
      // case ShowErrorAs.snackbar:
      //   showSnackbar(
      //     message: model.localizedMessage,
      //     preset: preset,
      //     isError: true,
      //     icon: model.icon,
      //     isDismissible: isDismissible,
      //   );
      //   break;
      //
      case ShowErrorAs.dialog:
        showDialog(
          title:
              'Error occurred', // Винести в лок ключ `FailureKey.dialogTitleError`
          content: model.localizedMessage,
          confirmText: 'OK',
          cancelText: 'Cancel',
          preset: preset,
          isError: true,
          isDismissible: isDismissible,
        );
        break;
      //
      case ShowErrorAs.infoDialog:
        showDialog(
          title: 'Error occurred',
          content: model.localizedMessage,
          confirmText: 'OK',
          cancelText: '',
          preset: preset,
          isError: false,
          isDismissible: isDismissible,
          isInfoDialog: true,
        );
        break;
      //
    }
  }

  //
}

///
/// 📌 Specifies how to display an error in UI
enum ShowErrorAs {
  // banner, snackbar,
  dialog,
  infoDialog,
}
