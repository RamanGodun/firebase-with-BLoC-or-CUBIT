import 'package:firebase_with_bloc_or_cubit/core/shared_modules/form_fields/extensions/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../utils/typedef.dart';
import '../text_widget.dart';



/// ✅[FormSubmitButton] a submit button, that reacts to form validation and shows loader animation
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
          tag: 'submit',
          child: ElevatedButton(
            onPressed:
                (status.canSubmit && isValidated)
                    ? () => onSubmit(context)
                    : null,
            style:
                style ??
                ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  disabledBackgroundColor: Colors.grey.shade400,
                  disabledForegroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder:
                  (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  ),
              child:
                  isLoading
                      ? const SizedBox(
                        key: ValueKey('loader'),
                        height: 24,
                        width: 24,
                        child: CupertinoActivityIndicator(radius: 12),
                      )
                      : TextWidget(
                        text,
                        TextType.titleMedium,
                        key: const ValueKey('text'),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
            ),
          ),
        );
      },
    );
  }
}
