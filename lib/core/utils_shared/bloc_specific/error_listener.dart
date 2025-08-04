import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/failure_ui_mapper.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/extensible_part/failure_extensions/failure_led_retry_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base_modules/errors_handling/core_of_module/failure_entity.dart';
import '../../base_modules/errors_handling/core_of_module/utils/specific_for_bloc/consumable.dart';
import '../../base_modules/localization/core_of_module/init_localization.dart';
import '../../base_modules/localization/generated/locale_keys.g.dart';
import '../../base_modules/overlays/core/enums_for_overlay_module.dart';
import '../../base_modules/overlays/utils/overlay_utils.dart';

/// [CustomErrorListener] — Generic BlocListener for showing error dialogs with optional retry.
/// ✅ DRY error handling for forms (SignIn, SignUp, etc).
//
final class CustomErrorListener<
  TCubit extends Cubit<TState>,
  TState extends Object
>
    extends StatelessWidget {
  ///---------------------------
  //
  final Widget child;
  // Extracts a consumable failure from state (e.g., state.failure).
  final Consumable<dynamic>? Function(TState state) failureSelector;
  // Decides when to trigger the error listener.
  final bool Function(TState prev, TState curr) listenWhen;
  // Callback to execute retry logic (e.g., cubit.submit).
  final VoidCallback onRetry;
  // Optional cleanup/reset callback after error is shown.
  final void Function(BuildContext context, TCubit cubit)? onReset;

  const CustomErrorListener({
    required this.child,
    required this.failureSelector,
    required this.listenWhen,
    required this.onRetry,
    this.onReset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //
    return BlocListener<TCubit, TState>(
      listenWhen: listenWhen,

      /// 📣 Show error once and reset failure + status
      listener: (context, state) {
        final cubit = context.read<TCubit>();
        final consumableError = failureSelector(state);
        final error = consumableError?.consume();

        if (error != null) {
          final isRetryable = (error is Failure && error.isRetryable);

          /// Show retryable dialog if supported, otherwise info dialog.
          if (isRetryable) {
            context.showError(
              error.toUIEntity(),
              showAs: ShowAs.dialog,
              onConfirm: OverlayUtils.dismissAndRun(onRetry, context),
              confirmText: AppLocalizer.translateSafely(
                LocaleKeys.buttons_retry,
              ),
            );
          } else {
            context.showError(error.toUIEntity(), showAs: ShowAs.infoDialog);
          }

          /// Run custom reset/cleanup if provided.
          onReset?.call(context, cubit);
        }
      },

      child: child,
    );
  }
}
