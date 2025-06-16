import 'package:firebase_with_bloc_or_cubit/core/shared_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_bloc_or_cubit/features/form_fields/extensions/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/general_utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/general_utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import '../../../../core/shared_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../../../core/general_utils/spider/images_paths.dart';
import '../../../../core/shared_modules/theme/core/constants/_app_constants.dart'
    show AppSpacing;
import '../../../../core/shared_layers/shared_presentation/shared_widgets/text_button.dart';
import '../../../form_fields/use_auth_focus_nodes.dart';
import '../../../form_fields/widgets/_fields_factory.dart';
import '../../../form_fields/widgets/button_for_forms.dart';
import '../../../form_fields/widgets/password_visibility_icon.dart';
import '../../../../core/general_utils/typedef.dart';
import 'cubit/sign_up_page_cubit.dart';

part 'sign_up_widgets.dart';

/// 🧾 [SignUpView] — Full UI layout for Sign Up screen
/// ✅ Includes all form fields, interactions, and field focus handling

final class SignUpView extends HookWidget {
  //--------------------------------------

  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    //
    // 📌 Shared focus nodes for form fields
    final focusNodes = useAuthFocusNodes();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          // 🔕 Dismiss keyboard on outside tap
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
                  shrinkWrap: true,
                  children: [
                    /// 🔰 Logo with optional hero animation
                    const _LogoImage(),
                    const SizedBox(height: AppSpacing.l),

                    /// 👤 Name input
                    _NameField(
                      focusNode: focusNodes.name,
                      nextFocusNode: focusNodes.email,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    /// 📧 Email input
                    _EmailField(
                      focusNode: focusNodes.email,
                      nextFocusNode: focusNodes.password,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    /// 🔒 Password input
                    _PasswordField(
                      focusNode: focusNodes.password,
                      nextFocusNode: focusNodes.confirmPassword,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    /// 🔐 Confirm password input
                    _ConfirmPasswordField(
                      focusNode: focusNodes.confirmPassword,
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    /// 🚀 Form submission button
                    const _SubmitButton(),
                    const SizedBox(height: AppSpacing.xxxs),

                    /// 🔁 Redirect to Sign In page
                    const _RedirectToSignInButton(),
                  ],
                )
                .centered() // 📍 Center the column vertically
                .withPaddingHorizontal(AppSpacing.l), // ↔ Horizontal padding
          ),
        ),
      ),
    );
  }
}
