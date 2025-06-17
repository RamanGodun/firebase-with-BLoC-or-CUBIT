import 'package:firebase_with_bloc_or_cubit/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/core/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/navigation/widgets/button_for_go_router.dart';
import 'package:firebase_with_bloc_or_cubit/core/layers_shared/presentation_layer_shared/widgets_shared/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/localization/widgets/text_widget.dart';

import '../../../modules_shared/navigation/_imports_for_router.dart'
    show RoutesNames;

/// ❌ Page shown when route is not found.
final class PageNotFound extends StatelessWidget {
  final String errorMessage;

  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: LocaleKeys.pages_not_found_title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            errorMessage.isNotEmpty
                ? errorMessage
                : LocaleKeys.pages_not_found_message,
            TextType.error,
            alignment: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxm),
          const CustomButtonForGoRouter(
            title: LocaleKeys.pages_go_to_home,
            routeName: RoutesNames.home,
          ),
        ],
      ).centered().withPaddingAll(AppSpacing.l),
    );
  }
}
