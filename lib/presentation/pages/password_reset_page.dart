import 'package:firebase_with_bloc_or_cubit/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(
          'This is page for email  verification',
          TextType.titleMedium,
        ),
      ),
    );
  }
}
