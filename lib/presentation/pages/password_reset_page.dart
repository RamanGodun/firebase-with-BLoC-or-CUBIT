import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/presentation/widgets/custom_app_bar.dart';
import '../../core/constants/app_strings.dart';

/// 🔁 Page for initiating password reset process.
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.resetPasswordPageTitle),
      body: Container(),
    );
  }
}
