import 'package:firebase_with_bloc_or_cubit/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_bloc_or_cubit/features/form_fields/input_validation/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/modules_shared/navigation/app_routes/app_routes.dart';
import '../../../../core/modules_shared/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../../../core/utils_shared/spider/images_paths.dart';
import '../../../../core/modules_shared/theme/ui_constants/_app_constants.dart'
    show AppSpacing;
import '../../../form_fields/input_validation/_validation_enums.dart';
import '../../../form_fields/utils/use_auth_focus_nodes.dart';
import '../../../form_fields/widgets/_fields_factory.dart';
import '../../../form_fields/widgets/password_visibility_icon.dart';
import '../../../form_fields/widgets/button_for_forms.dart';
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/text_button.dart';
import 'cubit/sign_in_page_cubit.dart';

part 'sign_in_widgets.dart';

/// 🔐 [SignInPageView] — Main UI layout for the sign-in form
/// ✅ Uses HookWidget for managing focus nodes & rebuild optimization

final class SignInPageView extends HookWidget {
  ///----------------------------------------
  const SignInPageView({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    // 📌 Initialize and memoize focus nodes for fields
    final focusNodes = useSignInFocusNodes();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: AutofillGroup(
              child:
                  ///
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.l,
                    ),
                    children: [
                      /// 🖼️ Logo with Hero animation for smooth transitions
                      const _LogoImage(),
                      const SizedBox(height: AppSpacing.l),

                      /// 📧 Email input field
                      _EmailField(
                        focusNode: focusNodes.email,
                        nextFocus: focusNodes.password,
                      ),
                      const SizedBox(height: AppSpacing.l),

                      /// 🔒 Password input field
                      _PasswordField(focusNode: focusNodes.password),
                      const SizedBox(height: AppSpacing.xl),

                      /// 🚀 Primary submit button
                      const _SubmitButton(),
                      const SizedBox(height: AppSpacing.xxxs),

                      /// 🔁 Link to redirect to sign-up screen
                      const _RedirectToSignUpButton(),
                    ],
                  ).centered(),
            ),
          ),
        ),
      ),
    );
  }

  //
}
