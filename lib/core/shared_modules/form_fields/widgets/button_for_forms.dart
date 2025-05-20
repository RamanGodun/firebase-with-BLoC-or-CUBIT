import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_localization/when_no_localization/app_strings.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/form_fields/extensions/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../shared_presentation/constants/_app_constants.dart';
import '../../../utils/typedef.dart';
import '../../app_localization/when_no_localization/text_widget.dart';
import '../../../shared_presentation/constants/app_keys.dart';

/// ✅ [FormSubmitButton] — A reusable submit button with validation logic and animated loading indicator
class FormSubmitButton<Cubit extends StateStreamable<State>, State>
    extends StatelessWidget {
  final String text;
  final SubmitCallback onSubmit;
  final FormzSubmissionStatus Function(State) statusSelector;
  final bool Function(State) isValidatedSelector;
  final ButtonStyle? style;

  const FormSubmitButton({
    super.key,
    required this.text,
    required this.onSubmit,
    required this.statusSelector,
    required this.isValidatedSelector,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
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
          tag: AppStrings.submitButtonTag,
          child: ElevatedButton(
            // 🚀 Trigger submit when form is valid and ready
            onPressed:
                (status.canSubmit && isValidated)
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
                      text,
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
