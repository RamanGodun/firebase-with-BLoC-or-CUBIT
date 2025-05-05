import 'package:firebase_with_bloc_or_cubit/core/shared_modules/form_fields/extensions/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/constants/_app_constants.dart'
    show AppSpacing;
import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared_modules/form_fields/use_auth_focus_nodes.dart';
import '../../../../core/shared_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/shared_modules/navigation/_imports_for_router.dart'
    show RoutesNames;
import '../../../../core/shared_modules/form_fields/widgets/button_for_forms.dart';
import '../../../../core/presentation/shared_widgets/text_button.dart';
import 'cubit/sign_in_page_cubit.dart';

part 'sign_in_widgets.dart';

/// 🔐 [SignInPageView] — Full sign-in form UI with optimized rebuilds
class SignInPageView extends HookWidget {
  const SignInPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // 📌 Focus management (shared across fields)
    final focusNodes = useAuthFocusNodes();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: Center(
            child: FocusTraversalGroup(
              child: AutofillGroup(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  children: [
                    /// 🖼️ Logo with Hero animation
                    const Hero(
                      tag: 'Logo',
                      child: Image(
                        image: AssetImage('assets/images/flutter_logo.png'),
                        width: 250,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.l),

                    /// 📧 Email
                    _EmailField(
                      focusNode: focusNodes.email,
                      nextFocus: focusNodes.password,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    /// 🔒 Password
                    _PasswordField(focusNode: focusNodes.password),
                    const SizedBox(height: AppSpacing.xl),

                    /// 🚀 Sign In submit Button
                    const _SubmitButton(),
                    const SizedBox(height: AppSpacing.s),

                    /// 🔁 Redirect  to Sign Up page
                    const _RedirectToSignUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
