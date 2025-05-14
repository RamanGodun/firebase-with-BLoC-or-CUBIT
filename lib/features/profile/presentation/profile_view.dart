import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared_modules/localization/language_toggle_w.dart';
import '../../../core/shared_presentation/constants/_app_constants.dart'
    show AppSpacing;
import '../../../core/shared_modules/localization/app_strings.dart';
import '../../../core/shared_presentation/shared_widgets/loading_view.dart';
import '../../shared/shared_domain/shared_entities/_user.dart';
import '../../../core/shared_presentation/shared_widgets/custom_app_bar.dart';
import '../../../core/shared_presentation/shared_widgets/text_widget.dart';
import '../../../core/shared_modules/theme/theme_toggle_widget.dart';
import 'cubit/profile_page_cubit.dart';

part 'widgets_for_profile_view.dart';

/// 📄 [ProfileView] — Handles state for loading, error, and loaded profile states
/// ✅ Reacts to [ProfileCubit] and shows appropriate UI
//----------------------------------------------------------------

final class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      appBar:
      ///
      const CustomAppBar(
        title: AppStrings.profilePageTitle,
        actionWidgets: [ThemeToggleIcon(), LanguageToggleIcon()],
        isNeedPaddingAfterActionIcon: true,
      ),

      ///
      body:
      ///
      BlocBuilder<ProfileCubit, ProfileState>(
        builder:
            (context, state) => switch (state) {
              ProfileInitial() => const SizedBox.shrink(),
              ProfileLoading() => const LoadingView(),
              ProfileError() => const _ErrorContent(),
              ProfileLoaded(:final user) => _UserProfileCard(user: user),
            },
      ),
    );
  }
}
