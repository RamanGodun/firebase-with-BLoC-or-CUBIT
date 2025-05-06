import 'package:firebase_with_bloc_or_cubit/core/shared_modules/form_fields/extensions/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;

import '../../../../core/constants/_app_constants.dart' show AppSpacing;
import '../../../../core/constants/app_strings.dart' show AppStrings;
import '../../../../core/shared_presentation/shared_widgets/text_button.dart';
import '../../../../core/shared_modules/form_fields/use_auth_focus_nodes.dart';
import '../../../../core/shared_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/shared_modules/form_fields/widgets/button_for_forms.dart';
import '../../../../core/shared_modules/form_fields/widgets/password_visibility_icon.dart';
import '../../../../core/utils/typedef.dart';
import 'cubit/sign_up_page_cubit.dart';

part 'sign_up_widgets.dart';

/// 🧾 [SignUpView] - Contains full form UI and field logic
class SignUpView extends HookWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    // 📌 Focus management (shared across fields)
    final focusNodes = useAuthFocusNodes();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                /// 🔰 Logo
                const Hero(
                  tag: 'Logo',
                  child: Image(
                    image: AssetImage('assets/images/flutter_logo.png'),
                    height: 150,
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                /// 👤 Name
                _NameField(
                  focusNode: focusNodes.name,
                  nextFocusNode: focusNodes.email,
                ),
                const SizedBox(height: AppSpacing.l),

                /// 📧 Email
                _EmailField(
                  focusNode: focusNodes.email,
                  nextFocusNode: focusNodes.password,
                ),
                const SizedBox(height: AppSpacing.l),

                /// 🔒 Password
                _PasswordField(
                  focusNode: focusNodes.password,
                  nextFocusNode: focusNodes.confirmPassword,
                ),
                const SizedBox(height: AppSpacing.l),

                /// 🔐 Confirm Password
                _ConfirmPasswordField(focusNode: focusNodes.confirmPassword),
                const SizedBox(height: AppSpacing.xxxl),

                /// 🚀 Submit button
                const _SubmitButton(),
                const SizedBox(height: AppSpacing.s),

                /// 🔁 Redirect text button
                const _RedirectToSignInButton(),
              ],
            ).centered().withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }
}
