import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/presentation/themes/theme_constants.dart';
import '../../core/utils/helpers/general_helper.dart';
import '../text_widget.dart';

/// 🎨 [CustomButton] – reusable styled button with optional navigation.
class CustomButton extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Helpers.getColorScheme(context);
    final isDarkMode = Helpers.isDarkMode(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: colorScheme.primary.withOpacity(isDarkMode ? 0.5 : 0.59),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
        onPressed: onPressed ?? () => Helpers.pushTo(context, child),
        child: TextWidget(
          title,
          TextType.titleMedium,
          color: AppConstants.white,
        ),
      ),
    );
  }
}
