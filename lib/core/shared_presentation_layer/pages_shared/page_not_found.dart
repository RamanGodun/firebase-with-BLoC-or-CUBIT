import 'package:firebase_with_bloc_or_cubit/core/base_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x_barrel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation_layer/widgets_shared/app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/localization/widgets/text_widget.dart';
import '../../base_modules/theme/ui_constants/_app_constants.dart';

/// ❌ Page shown when route is not found

final class PageNotFound extends StatelessWidget {
  ///-------------------------------------------

  final String errorMessage;
  const PageNotFound({super.key, required this.errorMessage});
  //

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: const CustomAppBar(title: LocaleKeys.errors_page_not_found_title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            errorMessage.isNotEmpty
                ? errorMessage
                : LocaleKeys.errors_page_not_found_message,
            TextType.error,
            alignment: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxm),
          // const CustomButtonForGoRouter(
          //   title: LocaleKeys.pages_go_to_home,
          //   routeName: RoutesNames.home,
          // ),
        ],
      ).centered().withPaddingAll(AppSpacing.l),
    );
  }
}
