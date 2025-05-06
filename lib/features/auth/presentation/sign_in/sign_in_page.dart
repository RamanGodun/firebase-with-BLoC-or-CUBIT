import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../services/sign_in_service.dart';
import '../../../../core/shared_modules/form_fields/extensions/formz_status_x.dart';
import '../../../../core/shared_modules/overlay/_overlay_service.dart';
import '../../domain/use_cases/ensure_profile_created.dart';
import '../../domain/use_cases/sign_in.dart';
import 'cubit/sign_in_page_cubit.dart';
import 'sign_in_view.dart';

/// 🔐 [SignInPage] — Entry point for the sign-in feature
/// ✅ Provides scoped Cubit with injected services
//----------------------------------------------------------------

class SignInPage extends StatelessWidget {
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

/// 🔄 [_SignInListenerWrapper] — Listens for submission failures
/// ✅ Displays error overlay and resets status after delay
//----------------------------------------------------------------

class _SignInListenerWrapper extends StatelessWidget {
  const _SignInListenerWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInPageState>(
      listenWhen:
          (prev, curr) =>
              prev.status != curr.status && curr.status.isSubmissionFailure,
      listener: (context, state) {
        if (state.failure != null) {
          OverlayNotificationService.dismissIfVisible();
          context.showFailureDialog(state.failure!);
        }

        // Optional: delay before resetting status to avoid UI jitter
        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) {
            context.read<SignInCubit>().resetStatus();
          }
        });
      },
      child: const SignInPageView(),
    );
  }
}
