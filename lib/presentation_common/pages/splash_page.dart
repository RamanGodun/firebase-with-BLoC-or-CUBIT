import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';

/// ⏳ Initial splash screen shown during app startup.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colorScheme.primary;

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
