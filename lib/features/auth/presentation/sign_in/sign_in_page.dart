import 'package:firebase_with_bloc_or_cubit/core/foundation/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/foundation/overlays/core/enums_for_overlay_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app_start_up/di_container/di_container.dart';
import '../../../form_fields/utils/_form_validation_service.dart';
import '../../services/sign_in_service.dart';
import '../../../form_fields/input_validation/formz_status_x.dart';
import '../../domain/use_cases/ensure_profile_created.dart';
import '../../domain/use_cases/sign_in.dart';
import 'cubit/sign_in_page_cubit.dart';
import 'sign_in_view.dart';

/// 🔐 [SignInPage] — Entry point for the sign-in feature
/// ✅ Provides scoped Cubit with injected services

final class SignInPage extends StatelessWidget {
  ///----------------------------------------
  const SignInPage({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      create:
          (_) => SignInCubit(
            SignInService(
              di<SignInUseCase>(),
              di<EnsureUserProfileCreatedUseCase>(),
            ),
            di<FormValidationService>(),
          ),
      child: const _SignInListenerWrapper(),
    );
  }
}

////

////

/// 🔄 [_SignInListenerWrapper] — Bloc listener for one-shot error feedback.
/// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.

final class _SignInListenerWrapper extends StatelessWidget {
  ///-----------------------------------------------------
  const _SignInListenerWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInPageState>(
      //
      listenWhen:
          (prev, curr) =>
              prev.status != curr.status && curr.status.isSubmissionFailure,

      /// 📣 Show error once and reset failure + status
      listener: (context, state) {
        final model = state.failure?.consume();
        print('[🔥 showError listener] model: $model');
        if (model != null) {
          context.showError(model, showAs: ShowAs.infoDialog);
          context.read<SignInCubit>()
            ..resetStatus()
            ..clearFailure();
        } else {
          print('[❌ Skipped overlay] Model was already consumed.');
        }
      },

      ///
      child: const SignInPageView(),
    );
  }
}
