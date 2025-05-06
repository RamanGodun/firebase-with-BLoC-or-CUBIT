import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/custom_app_bar.dart';
import '../../constants/app_strings.dart';

/// 🔁 Page for initiating password reset process.
final class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.resetPasswordPageTitle),
      body: Container(),
    );
  }
}
