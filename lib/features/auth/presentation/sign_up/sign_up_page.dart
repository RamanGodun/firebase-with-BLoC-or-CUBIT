import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../../../core/shared_modules/form_fields/forms_status_extension.dart';
import '../../../../core/shared_modules/overlay/_overlay_service.dart';
import '../../domain/use_cases/sign_up.dart';
import 'cubit/sign_up_page_cubit.dart';
import 'sign_up_view.dart';

/// 🧾 [SignUpPage] - Entry point with BLoC provider and listener
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(signUpUseCase: di<SignUpUseCase>()),
      child: BlocListener<SignUpCubit, SignUpState>(
        listenWhen:
            (prev, curr) =>
                prev.status != curr.status && curr.status.isSubmissionFailure,
        listener: (context, state) {
          if (state.failure != null) {
            OverlayNotificationService.dismissIfVisible();
            context.showFailureDialog(state.failure!);
            context.read<SignUpCubit>().resetStatus();
          }
        },
        child: const SignUpView(),
      ),
    );
  }
}
