import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/custom_app_bar.dart';
import '../../shared_modules/app_localization/app_strings.dart';

/// 🔐 Page for changing user password.
final class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.changePasswordPageTitle),
      body: Container(),
    );
  }
}
