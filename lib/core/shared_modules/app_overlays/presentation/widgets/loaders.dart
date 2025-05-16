import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/app_loader.dart';

/// 🔄 [LoaderWidget] — Flexible loader, used for splash-screen or in build
//----------------------------------------------------------------

final class LoaderWidget extends StatelessWidget {
  final bool wrapInMaterialApp;
  final TargetPlatform? platformOverride;
  final Color? backgroundColor;

  const LoaderWidget({
    super.key,
    this.wrapInMaterialApp = false,
    this.platformOverride,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final loader = Center(child: AppLoader(platformOverride: platformOverride));

    return wrapInMaterialApp
        ? MaterialApp(home: loader)
        : Material(type: MaterialType.transparency, child: loader);
  }
}
