import 'package:flutter/material.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '../../animation/animated_overlay_wrapper.dart';
import 'overlay_enums.dart';
import '../state_driven_flow/conflicts_strategy/police_resolver.dart';
import '../state_driven_flow/overlay_entries/_overlay_entries.dart';
import 'platform_mapper.dart';
import '../presentation/overlay_presets/overlay_presets.dart';
import '../state_driven_flow/overlay_dispatcher/overlay_dispatcher_interface.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/animation/animation_engines/_context_x_for_engines.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';

/// 🎯 [OverlayBaseMethods] — Unified extension for low-level overlay
///  rendering methods (showBanner, showDialog, showSnackbar)
//-------------------------------------------------------------

extension OverlayBaseMethods on BuildContext {
  //

  /// 5️⃣  📥 Adds a new request to the [IOverlayDispatcher]
  void addOverlayRequest(OverlayUIEntry entry) {
    /// 🔌 Direct access to [IOverlayDispatcher] from DI
    final dispatcher = di<IOverlayDispatcher>();
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

  /// 🪧 Shows a platform-aware banner (iOS/Android) using optional preset
  void showBanner({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
    Duration autoDismissDuration = const Duration(seconds: 3),
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

  /// 🍞 Shows a platform-aware snackbar (iOS/Android) using optional preset
  void showSnackbar({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
    Duration autoDismissDuration = const Duration(seconds: 3),
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

  ///
}
