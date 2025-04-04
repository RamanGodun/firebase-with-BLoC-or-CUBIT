import 'package:flutter/cupertino.dart';
import '../../core/utils/helpers/general_helper.dart';
import '../text_widget.dart';

/// 🪟🌍 Custom button widget that handles navigation via GoRouter or executes callback.
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.primary.withOpacity(0.65),
          onPressed: () => _handleButtonPress(context),
          child: TextWidget(
            title,
            TextType.titleMedium,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  /// 🚀 Handles button press: executes callback or navigates to route.
  void _handleButtonPress(BuildContext context) {
    if (onPressedCallback != null) {
      onPressedCallback!();
    } else if (routeName != null && routeName!.isNotEmpty) {
      Helpers.goTo(
        context,
        routeName!,
        pathParameters: pathParameters ?? const {},
        queryParameters: queryParameters ?? const {},
      );
    } else {
      debugPrint('⚠️ Error: routeName is null or empty.');
    }
  }
}

/*
?alternative way:
 if (voidCallBack != null) {
      voidCallBack!();
    } else if (routeName != null && routeName!.isNotEmpty) {
      Helpers.goTo(
        context,
        routeName!,
        pathParameters: pathParameters ?? const {},
        queryParameters: queryParameters ?? const {},
      );
    } else {
      debugPrint('Error: routeName is null or empty.');
    }
 */
