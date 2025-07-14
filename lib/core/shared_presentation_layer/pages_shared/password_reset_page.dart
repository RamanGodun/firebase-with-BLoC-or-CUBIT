import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation_layer/widgets_shared/app_bar.dart';
import '../../base_modules/localization/generated/locale_keys.g.dart';

/// 🔁 Page for initiating password reset process.
final class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: LocaleKeys.pages_reset_password),
      body: Container(),
    );
  }
}
