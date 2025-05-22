import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlays/core/state_driven_overlay_flow_context_show_overlay_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../services/sign_up_service.dart';
import '../../../../core/shared_modules/form_fields/extensions/formz_status_x.dart';
import '../../domain/use_cases/sign_up.dart';
import 'cubit/sign_up_page_cubit.dart';
import 'sign_up_view.dart';

/// 🧾 [SignUpPage] — Entry point for the sign-up feature
/// ✅ Provides scoped Cubit with injected service
//----------------------------------------------------------------

final class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(SignUpService(di<SignUpUseCase>())),
      child: const _SignUpListenerWrapper(),
    );
  }
}

/// 🔄 [_SignUpListenerWrapper] — Bloc listener for one-shot error feedback.
/// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.
//----------------------------------------------------------------

final class _SignUpListenerWrapper extends StatelessWidget {
  const _SignUpListenerWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      ///
      listenWhen:
          (prev, curr) =>
              prev.status != curr.status && curr.status.isSubmissionFailure,

      /// 📣 Show error once and reset failure + status
      listener: (context, state) {
        final model = state.failure?.consume();
        if (model != null) {
          context.showError( model);
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
