import 'package:firebase_with_bloc_or_cubit/core/shared_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_presentation/shared_widgets/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../utils/spider/images_paths.dart';
import '../../../shared_modules/localization/generated/locale_keys.g.dart';
import '../../../shared_modules/navigation/_imports_for_router.dart'
    show RoutesNames;

/// 🏠 [HomePage] is shown after successful login.
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageWidth = context.screenWidth * 0.8;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.pages_home,
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
                Image.asset(ImagesPaths.blocLogoFull, width: imageWidth),
                const TextWidget(
                  LocaleKeys.info_bloc_slogan,
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
