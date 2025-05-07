import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/_app_constants.dart' show AppSpacing;
import '../../../core/constants/app_strings.dart';
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
        actionWidgets: [ThemeToggleIcon()],
        isNeedPaddingAfterActionIcon: true,
      ),

      ///
      body:
      ///
      BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            ///
            case ProfileStatus.loading:
              return const LoadingView();

            case ProfileStatus.error:
              return const _ErrorContent();

            case ProfileStatus.loaded:
              return _UserProfileCard(user: state.user);

            case ProfileStatus.initial:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
