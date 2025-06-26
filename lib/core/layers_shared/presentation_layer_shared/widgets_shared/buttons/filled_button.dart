import 'package:firebase_with_bloc_or_cubit/core/modules_shared/animation/widget_animation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/ui_constants/app_colors.dart';
import 'package:firebase_with_bloc_or_cubit/features/form_fields/input_validation/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../modules_shared/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../../../utils_shared/typedef.dart';
import '../../../../modules_shared/localization/widgets/text_widget.dart';
import '../../../../../features/form_fields/widgets/keys_for_widgets.dart';

/// ✅ [FormSubmitButton] — A reusable submit button
/// with validation logic and animated loading indicator

class FormSubmitButton<Cubit extends StateStreamable<State>, State>
    extends StatelessWidget {
  //---------------------------------------------------

  final String label;
  final SubmitCallback onSubmit;
  final FormzSubmissionStatus Function(State) statusSelector;
  final bool Function(State) isValidatedSelector;

  const FormSubmitButton({
    super.key,
    required this.label,
    required this.onSubmit,
    required this.statusSelector,
    required this.isValidatedSelector,
  });

  ///

  @override
  Widget build(BuildContext context) {
    //
    final isOverlayActive = context.select<OverlayStatusCubit, bool>(
      (cubit) => cubit.state,
    );

    return BlocBuilder<Cubit, State>(
      buildWhen:
          (prev, curr) =>
              statusSelector(prev) != statusSelector(curr) ||
              isValidatedSelector(prev) != isValidatedSelector(curr),
      builder: (context, state) {
        final status = statusSelector(state);
        final isValidated = isValidatedSelector(state);
        final isLoading = status.isInProgress;
        final colorScheme = context.colorScheme;

        return Hero(
          tag: 'submit',
          child: FilledButton(
            // 🎨 Custom button style or fallback to default
            style: context.filledButtonTheme.style?.copyWith(
              textStyle: MaterialStateProperty.all(
                context.textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),

            // 🚀 Trigger submit when form is valid and ready
            onPressed:
                (status.canSubmit && isValidated && !isOverlayActive)
                    ? () => onSubmit(context)
                    : null,

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
                      color:
                          !isValidated
                              ? AppColors.darkBorder
                              : colorScheme.onPrimary,
                      fontWeight:
                          !isValidated ? FontWeight.w400 : FontWeight.w500,
                      letterSpacing: 0.9,
                    ).withAnimationSwitcher()),
          ).withRoundedCorners(8).withPaddingTop(30),
        );
      },
    );
  }
}
