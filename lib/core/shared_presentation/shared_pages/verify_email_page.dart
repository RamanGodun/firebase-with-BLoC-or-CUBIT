import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/custom_app_bar.dart';
import '../../shared_modules/localization/app_strings.dart';

/// 📧 Page prompting user to verify their email.
final class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.verifyEmailPageTitle),
      body: Container(),
    );
  }
}
