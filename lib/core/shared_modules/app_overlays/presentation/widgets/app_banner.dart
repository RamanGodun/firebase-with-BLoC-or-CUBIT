// import 'package:flutter/material.dart';
// import '../overlay_presets/preset_props.dart';
// import 'app_banners.dart';

// /// 🪧 [AppBanner] — Platform-adaptive banner widget
// /// - Renders banner UI for [BannerOverlayEntry]
// /// - Uses material design on Android, [IOSBannerCard] on iOS/macOS
// ///----------------------------------------------------------------------------

// class AppBanner extends StatelessWidget {
//   final String message;
//   final IconData icon;
//   final OverlayUIPresetProps props; // 🎨 Styling preset
//   final TargetPlatform platform;

//   const AppBanner({
//     required this.message,
//     required this.icon,
//     required this.props,
//     required this.platform,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//     // switch (platform) {
//     //       //
//     //       // 🍎 iOS/macOS style: uses custom animated widget
//     //       TargetPlatform.iOS ||
//     //       TargetPlatform.macOS => IOSBannerCard(message: message, icon: icon),

//     //       // 🤖 Android/Web/Windows/Linux: Material-styled banner
//     //       _ => AndroidBannerCard(props: props, icon: icon, message: message),
//     //     };
//   }
// }
