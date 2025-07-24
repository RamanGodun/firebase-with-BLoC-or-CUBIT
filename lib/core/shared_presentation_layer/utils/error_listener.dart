import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/failure_led_retry_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base_modules/errors_handling/failures/failure_entity.dart';
import '../../base_modules/errors_handling/utils/for_bloc/consumable.dart';
import '../../base_modules/localization/app_localizer.dart';
import '../../base_modules/localization/generated/locale_keys.g.dart';
import '../../base_modules/overlays/core/enums_for_overlay_module.dart';
import '../../base_modules/overlays/utils/overlay_utils.dart';

/// [CustomErrorListener] — Universal BlocListener for error dialog+retry for forms
//
final class CustomErrorListener<
  TCubit extends Cubit<TState>,
  TState extends Object
>
    extends StatelessWidget {
  final Widget child;

  /// Стратегія отримання failure-об'єкта зі стейту (generic для SignUp/SignIn)
  final Consumable<dynamic>? Function(TState state) failureSelector;

  /// Стратегія, коли в state показувати dialog (наприклад, статус submissionFailure)
  final bool Function(TState prev, TState curr) listenWhen;

  /// Retry callback для повтору дії
  final VoidCallback onRetry;

  /// Опціональний хук для cleanup/reset після показу помилки
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
      listener: (context, state) {
        final cubit = context.read<TCubit>();
        final consumableError = failureSelector(state);
        final error = consumableError?.consume();

        if (error != null) {
          final isRetryable = (error is Failure && error.isRetryable);
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
          onReset?.call(context, cubit);
        }
      },
      child: child,
    );
  }
}
