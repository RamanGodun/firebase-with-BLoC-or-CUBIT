import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../utils_shared/timing_control/timing_config.dart';
import '../../animation/overlays_animation/animation_wrapper/animated_overlay_wrapper.dart';
import '../overlay_dispatcher/_overlay_dispatcher.dart';
import '../overlay_dispatcher/overlay_entries/_overlay_entries_registry.dart';
import 'enums_for_overlay_module.dart';
import 'platform_mapper.dart';
import '../overlays_presentation/overlay_presets/overlay_presets.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/animation/overlays_animation/animation_engines/android_animation_engine/_get_engine_context_x.dart';

/// 🎯 [OverlayBaseMethods] — Unified extension for low-level overlay
///  rendering methods (showBanner, showDialog, showSnackbar)
//
extension OverlayBaseMethods on BuildContext {
  ///--------------------------------------

  /// 5️⃣  📥 Adds a new request to the [IOverlayDispatcher]
  void addOverlayRequest(OverlayUIEntry entry) {
    dispatcher.enqueueRequest(this, entry);
  }

  /// 💬 Shows a short platform-adaptive dialog (iOS/Android)
  void showAppDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
    OverlayPriority priority = OverlayPriority.normal,
    bool isInfoDialog = false,
    Duration autoDismissDuration = Duration.zero,
  }) {
    //
    // 1️⃣ Get engine for dialog, based on platform
    final engine = getEngine(OverlayCategory.dialog);

    // 2️⃣ Resolve platform-specific dialog widget
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

    // 3️⃣ Wrap with [AnimatedOverlayWrapper], that controls lifecycle and animation
    final animatedDialog = AnimatedOverlayWrapper(
      engine: engine,
      displayDuration: autoDismissDuration,
      builder: (_) => dialogWidget,
    );

    // 4️⃣ Create overlay entry
    final entry = DialogOverlayEntry(
      widget: animatedDialog,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
      isError: isError,
      priority: priority,
    );

    // 5️⃣  📥 Adds a new request to the queue
    addOverlayRequest(entry);
  }

  ///

  /// 🪧 Shows a platform-aware banner (iOS/Android) using optional preset
  void showBanner({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
    Duration autoDismissDuration = AppDurations.sec3,
    OverlayPriority priority = OverlayPriority.normal,
  }) {
    //
    // 1️⃣ Get engine for banner based on platform
    final engine = getEngine(OverlayCategory.banner);

    // 2️⃣ Resolve platform-specific banner widget
    final bannerWidget = PlatformMapper.resolveAppBanner(
      platform: platform,
      engine: engine,
      message: message,
      icon: icon ?? Icons.info,
      presetProps: preset.resolve(),
    );

    // 3️⃣ Wrap with [AnimatedOverlayWrapper], that controls lifecycle and animation
    final animatedBanner = AnimatedOverlayWrapper(
      engine: engine,
      displayDuration: autoDismissDuration,
      builder: (_) => bannerWidget,
    );

    // 4️⃣ Create overlay entry
    final entry = BannerOverlayEntry(
      widget: animatedBanner,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
      isError: isError,
      priority: priority,
    );

    // 5️⃣  📥 Adds a new request to the queue
    addOverlayRequest(entry);
  }

  ///

  /// 🍞 Shows a platform-aware snackbar (iOS/Android) using optional preset
  void showSnackbar({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
    Duration autoDismissDuration = AppDurations.sec3,
    OverlayPriority priority = OverlayPriority.normal,
  }) {
    //
    // 1️⃣ Get engine for banner based on platform
    final engine = getEngine(OverlayCategory.snackbar);

    // 2️⃣ Resolve platform-specific banner widget
    final snackbarWidget = PlatformMapper.resolveAppSnackbar(
      platform: platform,
      engine: engine,
      message: message,
      icon: icon ?? Icons.info,
      presetProps: preset.resolve(),
    );

    // 3️⃣ Wrap with [AnimatedOverlayWrapper], that controls lifecycle and animation
    final animatedSnackbar = AnimatedOverlayWrapper(
      engine: engine,
      displayDuration: autoDismissDuration,
      builder: (_) => snackbarWidget,
    );

    // 4️⃣ Create overlay entry
    final entry = SnackbarOverlayEntry(
      widget: animatedSnackbar,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
      isError: isError,
      priority: priority,
    );

    // 5️⃣  📥 Adds a new request to the queue
    addOverlayRequest(entry);
  }

  //
}
