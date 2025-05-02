import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/presentation_common/widgets/custom_app_bar.dart';
import '../../features/domain/constants/app_strings.dart';

/// 🔐 Page for changing user password.
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.changePasswordPageTitle),
      body: Container(),
    );
  }
}
