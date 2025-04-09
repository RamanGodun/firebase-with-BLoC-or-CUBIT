import 'package:flutter/material.dart';
import '../../core/utils_and_services/helper.dart';

/// ⏳ Initial splash screen shown during app startup.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Helpers.getColorScheme(context).primary;

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
