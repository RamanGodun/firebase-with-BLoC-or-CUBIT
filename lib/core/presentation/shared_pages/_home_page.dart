import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/constants/app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/constants/app_strings.dart';
import 'package:firebase_with_bloc_or_cubit/features/auth/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/shared_widgets/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/shared_widgets/text_widget.dart';

import '../../shared_moduls/navigation/_imports_for_router.dart' show RoutesNames;

/// 🏠 Home Page — shown after successful login.
class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.8;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.homePageTitle,
          actionIcons: const [
            AppConstants.profileIcon,
            AppConstants.logoutIcon,
          ],
          actionCallbacks: [
            () => context.pushToNamed(RoutesNames.profile),
            () => context.read<AuthBloc>().add(SignoutRequestedEvent()),
          ],
          isNeedPaddingAfterActionIcon: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/bloc_logo_full.png',
                width: imageWidth,
              ),
              const SizedBox(height: AppSpacing.m),
              const TextWidget(
                AppStrings.blocSlogan,
                TextType.titleMedium,
                alignment: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
