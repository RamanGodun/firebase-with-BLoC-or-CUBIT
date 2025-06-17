import 'package:firebase_with_bloc_or_cubit/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/theme_utils/blur_wrapper.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/core/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/layers_shared/presentation_layer_shared/widgets_shared/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/localization/widgets/text_widget.dart';
import '../../../modules_shared/theme/theme_utils/box_decorations/_box_decorations_factory.dart';
import '../../../utils_shared/spider/images_paths.dart';
import '../../../modules_shared/localization/generated/locale_keys.g.dart';
import '../../../modules_shared/navigation/_imports_for_router.dart'
    show RoutesNames;

/// 🏠 [HomePage] is shown after successful login.
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final isDark = context.isDarkMode;
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
        body: BlurContainer(
          borderRadius: UIConstants.commonBorderRadius,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.huge,
            ),
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecorationFactory.iosCard(isDark),
            child:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpacing.xxxm,
                  children: [
                    Image.asset(ImagesPaths.blocLogoFull, width: imageWidth),
                    const TextWidget(
                      LocaleKeys.info_bloc_slogan,
                      TextType.titleMedium,
                      alignment: TextAlign.center,
                      isTextOnFewStrings: true,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ).centered(),
          ),
        ),
      ),
    );
  }
}
