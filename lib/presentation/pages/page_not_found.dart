import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/constants/app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/constants/app_strings.dart';
import 'package:firebase_with_bloc_or_cubit/presentation/widgets/buttons/button_for_go_router.dart';
import 'package:firebase_with_bloc_or_cubit/presentation/widgets/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/presentation/widgets/text_widget.dart';

import '../../core/navigation/router.dart' show RoutesNames;

/// ❌ Page shown when route is not found.
class PageNotFound extends StatelessWidget {
  final String errorMessage;

  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.pageNotFoundTitle),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
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
          ),
        ),
      ),
    );
  }
}
