import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../sign_up_utils/sign_up_service.dart';
import '../../../../core/shared_modules/form_fields/extensions/formz_status_x.dart';
import '../../../../core/shared_modules/overlay/_overlay_service.dart';
import '../../domain/use_cases/sign_up.dart';
import 'cubit/sign_up_page_cubit.dart';
import 'sign_up_view.dart';

/// 🧾 [SignUpPage] — Entry point for Sign Up screen with scoped Cubit DI
/// ✅ Sets up [SignUpCubit] and listens for submission failures
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

/// 🔄 [_SignUpListenerWrapper] — Listens for failed submissions and shows UI feedback
/// ✅ Displays failure dialog and resets status after delay
//----------------------------------------------------------------

final class _SignUpListenerWrapper extends StatelessWidget {
  const _SignUpListenerWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen:
          (prev, curr) =>
              prev.status != curr.status && curr.status.isSubmissionFailure,
      listener: (context, state) {
        if (state.failure != null) {
          OverlayNotificationService.dismissIfVisible();
          context.showFailureDialog(state.failure!);

          // ⏱ Reset status after delay to allow clean retry
          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) {
              context.read<SignUpCubit>().resetStatus();
            }
          });
        }
      },
      child: const SignUpView(),
    );
  }
}
