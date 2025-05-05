import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/constants/app_strings.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/navigation/widgets/button_for_go_router.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/shared_widgets/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/core/presentation/shared_widgets/text_widget.dart';

import '../../shared_modules/navigation/_imports_for_router.dart'
    show RoutesNames;

/// ❌ Page shown when route is not found.
class PageNotFound extends StatelessWidget {
  final String errorMessage;

  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.pageNotFoundTitle),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            errorMessage.isNotEmpty
                ? errorMessage
                : AppStrings.pageNotFoundMessage,
            TextType.error,
            alignment: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.m),
          const CustomButtonForGoRouter(
            title: AppStrings.goToHomeButton,
            routeName: RoutesNames.home,
          ),
        ],
      ).centered().withPaddingAll(AppSpacing.l),
    );
  }
}
