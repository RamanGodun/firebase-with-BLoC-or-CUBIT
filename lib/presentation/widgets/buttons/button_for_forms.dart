import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../core/utils_and_services/helper.dart' show Helpers;
import '../text_widget.dart';

typedef SubmitCallback = void Function(BuildContext context);

class ReusableFormSubmitButton<Cubit extends StateStreamable<State>, State>
    extends StatelessWidget {
  final String text;
  final SubmitCallback onSubmit;
  final FormzSubmissionStatus Function(State) statusSelector;
  final bool Function(State) isValidatedSelector;

  /// Optional override for button styling
  final ButtonStyle? style;

  const ReusableFormSubmitButton({
    super.key,
    required this.text,
    required this.onSubmit,
    required this.statusSelector,
    required this.isValidatedSelector,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Helpers.getColorScheme(context);

    return BlocBuilder<Cubit, State>(
      buildWhen:
          (prev, curr) =>
              statusSelector(prev) != statusSelector(curr) ||
              isValidatedSelector(prev) != isValidatedSelector(curr),
      builder: (context, state) {
        final status = statusSelector(state);
        final isValidated = isValidatedSelector(state);
        final isLoading = status.isInProgress;

        return ElevatedButton(
          onPressed: isValidated && !isLoading ? () => onSubmit(context) : null,
          style:
              style ??
              ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                disabledBackgroundColor: Colors.grey.shade400,
                disabledForegroundColor: Colors.white70,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
          child:
              isLoading
                  ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : TextWidget(
                    text,
                    TextType.titleMedium,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
        );
      },
    );
  }
}
