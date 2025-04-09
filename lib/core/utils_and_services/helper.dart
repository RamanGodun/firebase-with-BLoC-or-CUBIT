import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../navigation/route_names.dart';

/*
? maybe separate to different utils and name them accordingly */

class Helpers {
  /// ================================
  /// * 🎨 NAVIGATION HELPERS
  /// ================================

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
      GoRouter.of(context).go(RouteNames.pageNotFound);
    }
  }

  ///
  static void pushToNamed(
    BuildContext context,
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    try {
      GoRouter.of(context).pushNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
    } catch (e) {
      GoRouter.of(context).go(RouteNames.pageNotFound);
    }
  }

  ///
  static pop(BuildContext context) {
    return Navigator.pop(context);
  }

  ///
  static Future<T?> pushTo<T>(BuildContext context, Widget child) {
    return Navigator.of(
      context,
    ).push<T>(MaterialPageRoute(builder: (_) => child));
  }

  /// ================================
  /// * 🎨 THEME HELPERS
  /// ================================

  /// 🌗 Checks if current theme is dark mode.
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// 🎨 **Retrieves the current theme** from the [BuildContext].
  static ThemeData getTheme(BuildContext context) => Theme.of(context);

  /// 🔠 **Returns the current text theme** from the app's theme.
  static TextTheme getTextTheme(BuildContext context) =>
      Theme.of(context).textTheme;

  /// 🎨 **Fetches the color scheme** from the app's theme.
  static ColorScheme getColorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

  /// ================================
  /// * 🎨 SPECIFIC METHODS
  /// ================================

  ///
}
