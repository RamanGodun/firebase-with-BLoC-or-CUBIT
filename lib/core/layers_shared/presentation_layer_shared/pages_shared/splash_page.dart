import 'package:flutter/material.dart';

import '../widgets_shared/app_loaders.dart';

/// ⏳ Initial splash screen shown during app startup.
/// ⏳ [SplashPage] — Displays a loading indicator while auth is resolving
final class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoaderWidget());
  }
}
