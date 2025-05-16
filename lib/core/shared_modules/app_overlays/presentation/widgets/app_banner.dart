import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../../app_animation/banner_host.dart';
import '../overlay_presets/preset_props.dart';

/// 🪧 [AppBanner] — Platform-adaptive banner widget
/// - Renders banner UI for [BannerOverlayEntry]
/// - Uses material design on Android, [BannerCard] on iOS/macOS
///----------------------------------------------------------------------------

class AppBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props; // 🎨 Styling preset
  final TargetPlatform platform;

  const AppBanner({
    required this.message,
    required this.icon,
    required this.props,
    required this.platform,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return switch (platform) {
      //
      // 🍎 iOS/macOS style: uses custom animated widget
      TargetPlatform.iOS ||
      TargetPlatform.macOS => OverlayBannerHost(message: message, icon: icon),

      // 🤖 Android/Web/Windows/Linux: Material-styled banner
      _ => Align(
        alignment: Alignment.topCenter,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(12),
          color: props.color.withOpacity(0.9),
          child: Padding(
            padding: props.contentPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Flexible(
                  child: TextWidget(
                    message,
                    TextType.bodyMedium,
                    color: context.colorScheme.primary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    isTextOnFewStrings: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    };
  }
}
