import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../../../core/shared_modules/overlays/core/overlay_core_types.dart';
import '../services/sign_in_service.dart';
import '../../../../core/shared_modules/form_fields/extensions/formz_status_x.dart';
import '../../domain/use_cases/ensure_profile_created.dart';
import '../../domain/use_cases/sign_in.dart';
import 'cubit/sign_in_page_cubit.dart';
import 'sign_in_view.dart';

/// 🔐 [SignInPage] — Entry point for the sign-in feature
/// ✅ Provides scoped Cubit with injected services
//----------------------------------------------------------------

final class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => SignInCubit(
            SignInService(
              di<SignInUseCase>(),
              di<EnsureUserProfileCreatedUseCase>(),
            ),
            overlayStatusCubit: di<OverlayStatusCubit>(),
          ),
      child: const _SignInListenerWrapper(),
    );
  }
}

/// 🔄 [_SignInListenerWrapper] — Bloc listener for one-shot error feedback.
/// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.
//----------------------------------------------------------------

final class _SignInListenerWrapper extends StatelessWidget {
  const _SignInListenerWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInPageState>(
      ///
      listenWhen:
          (prev, curr) =>
              prev.status != curr.status && curr.status.isSubmissionFailure,

      /// 📣 Show error once and reset failure + status
      listener: (context, state) {
        final model = state.failure?.consume();
        print('[🔥 showError listener] model: $model');
        if (model != null) {
          context.showError(model);
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
