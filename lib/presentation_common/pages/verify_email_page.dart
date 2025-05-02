import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/presentation_common/widgets/custom_app_bar.dart';
import '../../features/domain/constants/app_strings.dart';

/// 📧 Page prompting user to verify their email.
class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.verifyEmailPageTitle),
      body: Container(),
    );
  }
}
