import 'package:flutter/material.dart';

import '../widgets_shared/loaders/loader.dart';

/// ⏳ [SplashPage] — Displays a loading indicator

final class SplashPage extends StatelessWidget {
  ///-----------------------------------------
  const SplashPage({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    return const Scaffold(body: AppLoader());
    //
  }
}
