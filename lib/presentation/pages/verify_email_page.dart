import 'package:firebase_with_bloc_or_cubit/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(
          'This is page for email verification',
          TextType.titleMedium,
        ),
      ),
    );
  }
}
