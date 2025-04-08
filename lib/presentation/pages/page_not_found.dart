import 'package:firebase_with_bloc_or_cubit/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../core/navigation/route_names.dart';
import '../widgets/buttons/button_for_go_router.dart';
import '../widgets/text_widget.dart';

/// **Page Not Found**
/// - Displays an error message if the page is not found.
class PageNotFound extends StatelessWidget {
  final String errorMessage;

  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Page Not Found'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                errorMessage.isNotEmpty
                    ? errorMessage
                    : 'Oops! The page you’re looking for does not exist.',
                TextType.error,
                alignment: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const CustomButtonForGoRouter(
                title: 'to HomePage',
                routeName: RouteNames.home,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
