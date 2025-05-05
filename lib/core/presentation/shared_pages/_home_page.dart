import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/constants/app_strings.dart';
import 'package:firebase_with_bloc_or_cubit/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/shared_widgets/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/shared_widgets/text_widget.dart';
import '../../shared_modules/navigation/_imports_for_router.dart'
    show RoutesNames;

/// 🏠 [HomePage] is shown after successful login.
class HomePage extends StatelessWidget {
  static const String routeName = AppStrings.homeRoute;
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageWidth = context.screenWidth * AppConstants.sizeF08;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.homePageTitle,
          actionIcons: const [AppIcons.profile, AppIcons.logout],
          actionCallbacks: [
            () => context.pushToNamed(RoutesNames.profile),
            () => context.read<AuthBloc>().add(SignoutRequestedEvent()),
          ],
          isNeedPaddingAfterActionIcon: true,
        ),
        body:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.m,
              children: [
                Image.asset(AppStrings.blocLogoPath, width: imageWidth),
                const TextWidget(
                  AppStrings.blocSlogan,
                  TextType.titleMedium,
                  alignment: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ).centered(),
      ),
    );
  }
}
