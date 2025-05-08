import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../../../core/shared_modules/errors_handling/utils/failure_notifier.dart';
import '../../services/sign_up_service.dart';
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
/// ✅ Listens for `FormzSubmissionStatus.failure` and shows error dialog.
/// ✅ Uses [FailureNotifier] to consume and display failure only once.
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

      /// 📣 Show error once, then reset state after delay
      listener: (context, state) {
        FailureNotifier.handleAndReset(
          context,
          state.failure,
          onReset: () {
            final cubit = context.read<SignUpCubit>();
            cubit.resetStatus();
            cubit.clearFailure();
          },
        );
      },

      ///
      child: const SignUpView(),
    );
  }
}
