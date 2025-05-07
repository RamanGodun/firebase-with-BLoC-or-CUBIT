import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../../../core/utils/failure_notifier.dart';
import '../../services/sign_in_service.dart';
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
          ),
      child: const _SignInListenerWrapper(),
    );
  }
}

/// 🔄 [_SignInListenerWrapper] — Bloc listener for one-shot error feedback.
/// ✅ Listens for `FormzSubmissionStatus.failure` and shows error dialog.
/// ✅ Uses [FailureNotifier] to consume and display failure only once.
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

      /// 📣 Show error once, then reset state after delay
      listener: (context, state) {
        FailureNotifier.handleAndReset(
          context,
          state.failure,
          onReset: () {
            final cubit = context.read<SignInCubit>();
            cubit.resetStatus();
            cubit.clearFailure();
          },
        );
      },

      ///
      child: const SignInPageView(),
    );
  }
}
