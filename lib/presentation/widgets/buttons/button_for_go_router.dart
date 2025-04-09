import 'package:flutter/cupertino.dart';
import '../../../core/utils_and_services/helper.dart';
import '../text_widget.dart';

/// 🪟🌍 Custom button that navigates via GoRouter or executes a callback.
class CustomButtonForGoRouter extends StatelessWidget {
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
    final colorScheme = Helpers.getColorScheme(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: 12),
          borderRadius: BorderRadius.circular(14),
          color: colorScheme.primary.withOpacity(0.85),
          disabledColor: colorScheme.primary.withOpacity(0.3),
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

  /// 🚀 Either performs navigation or runs callback
  void _handleButtonPress(BuildContext context) {
    if (onPressedCallback != null) {
      onPressedCallback!();
      return;
    }

    if (routeName?.isNotEmpty ?? false) {
      Helpers.goTo(
        context,
        routeName!,
        pathParameters: pathParameters ?? const {},
        queryParameters: queryParameters ?? const {},
      );
    } else {
      debugPrint(
        '⚠️ [CustomButtonForGoRouter] No routeName or callback provided',
      );
    }
  }
}
