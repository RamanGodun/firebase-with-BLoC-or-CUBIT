import 'package:flutter/material.dart';

import '../app_overlays/presentation/widgets/banner_card.dart';
import 'animation_engine_interface.dart';
import 'banner_animation_service.dart';

/// 🧩 Host widget to attach animation engine (vsync)
final class OverlayBannerHost extends StatefulWidget {
  final String message;
  final IconData icon;

  const OverlayBannerHost({
    super.key,
    required this.message,
    required this.icon,
  });

  @override
  State<OverlayBannerHost> createState() => _OverlayBannerHostState();
}

final class _OverlayBannerHostState extends State<OverlayBannerHost>
    with TickerProviderStateMixin {
  late final IAnimationEngine _engine;

  @override
  void initState() {
    super.initState();
    _engine =
        BannerAnimationEngine()
          ..initialize(this)
          ..play();
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BannerCard(message: widget.message, icon: widget.icon, engine: _engine);
}
