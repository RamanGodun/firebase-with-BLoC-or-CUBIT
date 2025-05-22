import 'package:firebase_with_bloc_or_cubit/core/shared_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/navigation/widgets/button_for_go_router.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/localization/code_base_for_both_options/text_widget.dart';

import '../../shared_modules/navigation/_imports_for_router.dart'
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
          const SizedBox(height: AppSpacing.m),
          const CustomButtonForGoRouter(
            title: LocaleKeys.pages_go_to_home,
            routeName: RoutesNames.home,
          ),
        ],
      ).centered().withPaddingAll(AppSpacing.l),
    );
  }
}
