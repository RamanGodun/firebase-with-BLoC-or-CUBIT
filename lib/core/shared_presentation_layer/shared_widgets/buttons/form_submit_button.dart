import 'package:firebase_with_bloc_or_cubit/core/base_modules/form_fields/input_validation/x_on_forms_submition_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../../utils_shared/type_definitions.dart';
import 'filled_button.dart';

/// 🚀 [FormSubmitButton] — Bloc-aware smart submit button for forms.
///
/// 🧠 This widget acts as a **behavioral adapter** around [CustomFilledButton].
/// It listens to the given Bloc/Cubit and automatically:
///   - shows a loader during form submission
///   - disables itself if form is invalid or submission in progress
///   - respects overlay state (to avoid multiple submissions)
///
/// ✅ Common use case:
///   - Place at bottom of forms (SignIn, SignUp, ResetPassword, etc)
///   - Controlled declaratively using status and validation selectors
//
final class FormSubmitButton<Cubit extends StateStreamable<State>, State>
    extends StatelessWidget {
  ///--------------------------------------------------
  //
  final String label;
  final SubmitCallback onPressed;
  final FormzSubmissionStatus Function(State) statusSelector;
  final bool Function(State) isValidatedSelector;

  const FormSubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.statusSelector,
    required this.isValidatedSelector,
  });
  //

  @override
  Widget build(BuildContext context) {
    //
    /// Whether an overlay/dialog is active (blocks submission)
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
        final bool isEnabled =
            status.canSubmit && isValidated && !isOverlayActive;

        return CustomFilledButton(
          label: label,
          onPressed: isEnabled ? () => onPressed(context) : null,
          isLoading: isLoading,
          isEnabled: isEnabled,
          isValidated: isValidated,
        );
      },
    );
  }
}
