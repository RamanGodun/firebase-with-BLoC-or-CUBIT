import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/widgets/text_widget.dart';
import '../navigation/route_names.dart';

/*
? maybe separate to different utils and name them accordingly */

class Helpers {
  /// ================================
  /// * 🎨 NAVIGATION HELPERS
  /// ================================

  /// Pushes a new page onto the stack
  static Future<T?> pushTo<T>(BuildContext context, Widget child) {
    return Navigator.of(
      context,
    ).push<T>(MaterialPageRoute(builder: (_) => child));
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static void goToResetPassword(BuildContext context) {
    GoRouter.of(context).goNamed(RouteNames.resetPassword);
  }

  /// Navigates to a named route with optional parameters
  static void goTo(
    BuildContext context,
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    try {
      GoRouter.of(context).goNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
    } catch (e) {
      // Redirect to error page if route is not found
      GoRouter.of(context).go('/unknown');
    }
  }

  /// ================================
  /// * 🎨 THEME HELPERS
  /// ================================

  /// 🌗 Checks if current theme is dark mode.
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// 🎨 **Retrieves the current theme** from the [BuildContext].
  static ThemeData getTheme(BuildContext context) => Theme.of(context);

  /// 🔠 **Returns the current text theme** from the app's theme.
  static TextTheme getTextTheme(BuildContext context) =>
      Theme.of(context).textTheme;

  /// 🎨 **Fetches the color scheme** from the app's theme.
  static ColorScheme getColorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// ================================
  /// * 🎨 SNACKBARs
  /// ================================

  /// Shows a snackbar message
  static void showSnackbar(
    ScaffoldMessengerState scaffoldMessenger,
    String message,
  ) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: TextWidget(message, TextType.bodyMedium)),
    );
  }

  // ================ Controllers helpers =================== //
  static List<TextEditingController> createControllers(int count) {
    return List.generate(count, (index) => TextEditingController());
  }

  /// Disposes all controllers in the list
  static void disposeControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  /// ============== SPECIFIC METHODS ===================== //
  ///
}
