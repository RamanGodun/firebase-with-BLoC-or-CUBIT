import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation_layer/widgets_shared/app_bar.dart';
import '../../base_modules/localization/generated/locale_keys.g.dart';

/// 🔐 Page for changing user password.
final class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: LocaleKeys.pages_change_password),
      body: Container(),
    );
  }
}
