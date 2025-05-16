// import 'package:flutter/material.dart';
// import '../../../app_animation/animation_engine_interface.dart';
// import '../../../app_animation/banner_animation_service.dart';
// import 'banner_card.dart';

// /// 🎭 [AnimatedBanner] — entry widget that wires engine and builds UI
// /// - Keeps UI pure Stateless (via [BannerCard])
// /// - Engine is fully encapsulated and initialized in state
// ///----------------------------------------------------------------------------
// final class AnimatedBanner extends StatefulWidget {
//   final String message;
//   final IconData icon;

//   const AnimatedBanner({super.key, required this.message, required this.icon});

//   @override
//   State<AnimatedBanner> createState() => _AnimatedBannerState();
// }

// final class _AnimatedBannerState extends State<AnimatedBanner>
//     with TickerProviderStateMixin {
//   late final IAnimationEngine _engine;

//   @override
//   void initState() {
//     super.initState();
//     _engine = BannerAnimationEngine();
//     _engine.initialize(this);
//     _engine.play();
//   }

//   @override
//   Widget build(BuildContext context) =>
//       BannerCard(message: widget.message, icon: widget.icon, engine: _engine);

//   ///
//   @override
//   void dispose() {
//     _engine.dispose();
//     super.dispose();
//   }

//   ///
// }
