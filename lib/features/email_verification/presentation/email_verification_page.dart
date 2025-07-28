import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/theme/extensions/theme_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_bootstrap_and_config/app_configs/firebase/data_source_constants.dart';
import '../../../app_bootstrap_and_config/di_container/di_container.dart';
import '../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../core/shared_presentation_layer/widgets_shared/buttons/text_button.dart';
import '../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../core/base_modules/theme/ui_constants/app_colors.dart';
import '../../../core/shared_presentation_layer/widgets_shared/loaders/loader.dart';
import '../../auth/presentation/sign_out/sign_out_cubit/sign_out_cubit.dart';
import 'email_verification_cubit/email_verification_cubit.dart';

part 'widgets_for_email_verification_page.dart';

final class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // /
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<EmailVerificationCubit>()),
        BlocProvider.value(value: di<SignOutCubit>()),
      ],

      ///
      child: BlocListener<EmailVerificationCubit, EmailVerificationState>(
        listenWhen:
            (prev, curr) =>
                prev.status != curr.status &&
                curr.status == EmailVerificationStatus.verified,
        listener: (context, state) {
          context.goTo(RoutesNames.home);
        },

        ///
        child: BlocListener<EmailVerificationCubit, EmailVerificationState>(
          listenWhen: (prev, curr) => curr.failure?.consume() != null,
          listener: (context, state) {
            final error = state.failure?.consume();
            if (error != null) {
              // Показати діалог з помилкою
              context.showError(error.toUIEntity());
            }
          },

          child: const _VerifyEmailPageView(),
        ),
      ),
    );
  }
}

/// 🧼 [_VerifyEmailPageView] — screen that handles email verification polling
/// Automatically redirects when email gets verified
//
final class _VerifyEmailPageView extends StatelessWidget {
  ///--------------------------------------------
  const _VerifyEmailPageView();

  @override
  Widget build(BuildContext context) {
    //

    return BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
      builder: (context, state) {
        final status = state.status;
        return Scaffold(
          body: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(
                  context.isDarkMode ? 0.05 : 0.9,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  const _VerifyEmailInfo(),
                  //
                  AppTextButton(
                    label: LocaleKeys.buttons_resend_email,
                    onPressed:
                        () =>
                            context
                                .read<EmailVerificationCubit>()
                                .resendEmail(),
                  ).withPaddingBottom(AppSpacing.m),
                  //
                  (status == EmailVerificationStatus.loading)
                      ? const AppLoader()
                      : const VerifyEmailCancelButton(),
                ],
              ).withPaddingAll(AppSpacing.l),
            ),
          ).withPaddingHorizontal(AppSpacing.l),
        );
      },
    );
  }
}
