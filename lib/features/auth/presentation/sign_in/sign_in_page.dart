import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../services/sign_in_service.dart';
import '../../../../core/shared_modules/form_fields/forms_status_extension.dart';
import '../../../../core/shared_modules/overlay/_overlay_service.dart';
import '../../domain/use_cases/ensure_profile_created.dart';
import '../../domain/use_cases/sign_in.dart';
import 'cubit/sign_in_page_cubit.dart';
import 'sign_in_view.dart';

/// 🔐 [SignInPage] — Entry point (with scoped DI) for Auth screen for existing users
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

/// 🔄 [_SignInListenerWrapper] — Listens for failure & handles UI reactions
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
        // context.read<SignInCubit>().resetStatus();
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
