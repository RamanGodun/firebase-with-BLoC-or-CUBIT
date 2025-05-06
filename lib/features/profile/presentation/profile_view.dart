import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/_app_constants.dart' show AppSpacing;
import '../../../core/constants/app_strings.dart';
import '../../../core/shared_presentation/shared_widgets/loading_view.dart';
import '../../shared/shared_domain/shared_entities/user.dart';
import '../../../core/shared_modules/overlay/_overlay_service.dart';
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
      appBar: const CustomAppBar(
        title: AppStrings.profilePageTitle,
        actionWidgets: [ThemeToggleIcon()],
        isNeedPaddingAfterActionIcon: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.error && state.failure != null) {
            OverlayNotificationService.dismissIfVisible();
            context.showFailureDialog(state.failure!);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ProfileStatus.loading:
              return const LoadingView();

            case ProfileStatus.error:
              return const _ErrorContent();

            case ProfileStatus.loaded:
              return _UserProfileCard(user: state.user);

            case ProfileStatus.initial:
              return const SizedBox.shrink();

            ///
          }
        },
      ),
    );
  }

  //
}
