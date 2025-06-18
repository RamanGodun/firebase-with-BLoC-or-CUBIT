import 'package:flutter/material.dart';

import '../widgets_shared/app_loaders.dart';

/// ⏳ [SplashPage] — Displays a loading indicator

final class SplashPage extends StatelessWidget {
  ///-----------------------------------------
  const SplashPage({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    return const Scaffold(body: LoaderWidget());
    //
  }
}
