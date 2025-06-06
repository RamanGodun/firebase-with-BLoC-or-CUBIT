import 'package:firebase_with_bloc_or_cubit/core/shared_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared_layers/shared_presentation/constants/_app_constants.dart' show AppSpacing;
import '../../localization/code_base_for_both_options/text_widget.dart';
import '../../theme/core/app_colors.dart';

/// 🌍 [CustomButtonForGoRouter] styled full-width button,
/// that performs either GoRouter navigation or custom action.
base class CustomButtonForGoRouter extends StatelessWidget {
  final String title;
  final String? routeName;
  final Map<String, String>? pathParameters;
  final Map<String, dynamic>? queryParameters;
  final VoidCallback? onPressedCallback;

  const CustomButtonForGoRouter({
    super.key,
    required this.title,
    this.routeName,
    this.pathParameters,
    this.queryParameters,
    this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.s,
      ),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
          borderRadius: BorderRadius.circular(14),
          color: AppColors.primary85,
          disabledColor: AppColors.primary30,
          onPressed: () => _handleButtonPress(context),
          child: TextWidget(
            title,
            TextType.titleMedium,
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 🚀 Handles routing or fallback to onPressedCallback
  void _handleButtonPress(BuildContext context) {
    if (onPressedCallback != null) {
      onPressedCallback!();
      return;
    }

    if (routeName?.isNotEmpty ?? false) {
      context.goTo(
        routeName!,
        pathParameters: pathParameters ?? const {},
        queryParameters: queryParameters ?? const {},
      );
    } else {
      debugPrint('⚠️ [CustomButtonForGoRouter] No route or callback provided');
    }
  }
}
