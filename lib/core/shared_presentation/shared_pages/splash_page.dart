import 'package:flutter/material.dart';

import '../shared_widgets/loading_view.dart';

/// ⏳ Initial splash screen shown during app startup.
/// ⏳ [SplashPage] — Displays a loading indicator while auth is resolving
final class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoadingView());
  }
}
