import 'package:flutter/material.dart';
import '../../../widgets/text_widget.dart';
import '../../utils/helpers/general_helper.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: OutlinedButton(
        onPressed: () => Helpers.pushTo(context, child),
        child: TextWidget(title, TextType.button),
      ),
    );
  }
}

class CustomButtonForDialog extends StatelessWidget {
  const CustomButtonForDialog({
    super.key,
    required this.title,
    required this.child,
  });
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: OutlinedButton(
        onPressed:
            () => showDialog(
              context: context,
              builder: (c) {
                return child;
              },
            ),
        child: TextWidget(title, TextType.button),
      ),
    );
  }
}

class CustomButtonForGoRouter extends StatelessWidget {
  const CustomButtonForGoRouter({
    super.key,
    required this.title,
    this.routeName,
    this.pathParameters,
    this.queryParameters,
    this.voidCallBack,
  });

  final String title;
  final String? routeName;
  final Map<String, String>? pathParameters;
  final Map<String, dynamic>? queryParameters;
  final VoidCallback? voidCallBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () => _buttonOnPressed(context),
          child: TextWidget(title, TextType.button),
        ),
      ),
    );
  }

  void _buttonOnPressed(BuildContext context) {
    (voidCallBack != null)
        ? voidCallBack!()
        : (routeName == null)
        ? debugPrint('Error: routeName is null or empty.')
        : Helpers.goTo(
          context,
          routeName!,
          pathParameters: pathParameters ?? const {},
          queryParameters: queryParameters ?? const {},
        );

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
  }
}
