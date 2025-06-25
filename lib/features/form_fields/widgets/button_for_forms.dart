import 'package:firebase_with_bloc_or_cubit/core/modules_shared/animation/widget_animation_x.dart';
import 'package:firebase_with_bloc_or_cubit/features/form_fields/input_validation/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../core/modules_shared/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../../core/modules_shared/theme/ui_constants/app_colors.dart';
import '../../../core/utils_shared/typedef.dart';
import '../../../core/modules_shared/localization/widgets/text_widget.dart';
import 'keys_for_widgets.dart';

/// ✅ [FormSubmitButton] — A reusable submit button
/// with validation logic and animated loading indicator

class FormSubmitButton<Cubit extends StateStreamable<State>, State>
    extends StatelessWidget {
  //---------------------------------------------------

  final String label;
  final SubmitCallback onSubmit;
  final FormzSubmissionStatus Function(State) statusSelector;
  final bool Function(State) isValidatedSelector;
  final ButtonStyle? style;

  const FormSubmitButton({
    super.key,
    required this.label,
    required this.onSubmit,
    required this.statusSelector,
    required this.isValidatedSelector,
    this.style,
  });

  ///

  @override
  Widget build(BuildContext context) {
    //
    final isOverlayActive = context.select<OverlayStatusCubit, bool>(
      (cubit) => cubit.state,
    );
    final colorScheme = context.colorScheme;

    return BlocBuilder<Cubit, State>(
      buildWhen:
          (prev, curr) =>
              statusSelector(prev) != statusSelector(curr) ||
              isValidatedSelector(prev) != isValidatedSelector(curr),
      builder: (context, state) {
        final status = statusSelector(state);
        final isValidated = isValidatedSelector(state);
        final isLoading = status.isInProgress;

        return Hero(
          tag: 'submit',
          child: ElevatedButton(
            // 🚀 Trigger submit when form is valid and ready
            onPressed:
                (status.canSubmit && isValidated && !isOverlayActive)
                    ? () => onSubmit(context)
                    : null,

            // 🎨 Custom button style or fallback to default
            style:
                style ??
                ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  disabledBackgroundColor: AppColors.buttonDisabledBackground,
                  disabledForegroundColor: AppColors.buttonDisabledForeground,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  elevation: 2,
                ),

            // 🔁 Loader or animated label
            child:
                (isLoading
                    ? const SizedBox(
                      key: AppKeys.submitButtonLoader,
                      height: 24,
                      width: 24,
                      child: CupertinoActivityIndicator(radius: 12),
                    )
                    : TextWidget(
                      key: AppKeys.submitButtonText,
                      label,
                      TextType.titleMedium,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ).withAnimationSwitcher()),
          ).withRoundedCorners(8).withPaddingTop(30),
        );
      },
    );
  }
}
