import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation_layer/widgets_shared/app_bar.dart';
import '../../foundation/localization/generated/locale_keys.g.dart';

/// 📧 Page prompting user to verify their email

final class VerifyEmailPage extends StatelessWidget {
  ///----------------------------------------------
  const VerifyEmailPage({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: const CustomAppBar(title: LocaleKeys.pages_verify_email),
      body: Container(),
    );
  }
}
