import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_strings.dart' show AppStrings;
import '../../core/utils_and_services/helper.dart';
import '../../features/auth_bloc/auth_bloc.dart';
import '../../features/profile/profile_page.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.8;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.homePageTitle,
          actionIcons: const [Icons.account_circle, Icons.exit_to_app],
          actionCallbacks: [
            () => Helpers.pushTo(context, const ProfilePage()),
            () => context.read<AuthBloc>().add(SignoutRequestedEvent()),
          ],
          isNeedPaddingAfterActionIcon: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/bloc_logo_full.png',
                width: imageWidth,
              ),
              const SizedBox(height: 24.0),
              const TextWidget(
                'Bloc is an awesome\nstate management library\nfor Flutter!',
                TextType.titleMedium,
                alignment: TextAlign.center,
                fontWeight: FontWeight.w500,
                height: 1.4,
                enableShadow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
