import 'package:firebase_with_bloc_or_cubit/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/widgets_and_utils/blur_wrapper.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/layers_shared/presentation_layer_shared/widgets_shared/app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/localization/widgets/text_widget.dart';
import '../../../modules_shared/navigation/app_routes/app_routes.dart';
import '../../../modules_shared/theme/ui_constants/_app_constants.dart';
import '../../../modules_shared/theme/widgets_and_utils/box_decorations/_box_decorations_factory.dart';
import '../../../utils_shared/spider/images_paths.dart';
import '../../../modules_shared/localization/generated/locale_keys.g.dart';

/// 🏠 [HomePage] is shown after successful login

final class HomePage extends StatelessWidget {
  ///---------------------------------------
  const HomePage({super.key});
  //

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
          actionWidgets: [
            IconButton(
              icon: const Icon(AppIcons.profile),
              onPressed: () => context.pushToNamed(RoutesNames.profile),
            ).withPaddingOnly(right: AppSpacing.l),
          ],
        ),

        body: BlurContainer(
          borderRadius: UIConstants.commonBorderRadius,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            decoration: BoxDecorationFactory.iosCard(isDark),
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
            ),
          ),
        ),
      ),
    );
  }
}
