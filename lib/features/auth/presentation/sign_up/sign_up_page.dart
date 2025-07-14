import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app_bootstrap_and_config/di_container/di_container.dart';
import '../../../form_fields/utils/_form_validation_service.dart';
import '../../../form_fields/input_validation/formz_status_x.dart';
import '../../domain/use_cases/sign_up.dart';
import 'cubit/sign_up_page_cubit.dart';
import 'sign_up_view.dart';

/// 🧾 [SignUpPage] — Entry point for the sign-up feature
/// ✅ Provides scoped Cubit with injected service

final class SignUpPage extends StatelessWidget {
  ///-----------------------------------------
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      create:
          (_) => SignUpCubit(di<SignUpUseCase>(), di<FormValidationService>()),
      child: const _SignUpListenerWrapper(),
    );
  }
}

////

////

/// 🔄 [_SignUpListenerWrapper] — Bloc listener for one-shot error feedback.
/// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.

final class _SignUpListenerWrapper extends StatelessWidget {
  ///-----------------------------------------------------
  const _SignUpListenerWrapper();

  @override
  Widget build(BuildContext context) {
    //
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen:
          (prev, curr) =>
              prev.status != curr.status && curr.status.isSubmissionFailure,

      /// 📣 Show error once and reset failure + status
      listener: (context, state) {
        final model = state.failure?.consume();
        if (model != null) {
          context.showError(model);
          context.read<SignUpCubit>()
            ..resetStatus()
            ..clearFailure();
        }
      },

      ///
      child: const SignUpView(),
    );
  }
}
