import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/custom_app_bar.dart';
import '../../shared_modules/app_localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

/// 📧 Page prompting user to verify their email.
final class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.pages_verify_email.tr()),
      body: Container(),
    );
  }
}
