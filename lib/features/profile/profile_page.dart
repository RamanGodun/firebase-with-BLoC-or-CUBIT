import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart' show AppSpacing;
import '../../core/constants/app_strings.dart';
import '../../core/di/di_container.dart';
import '../../core/entities/user_model.dart';
import '../../core/utils_and_services/errors_handling/error_dialog.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/text_widget.dart';
import '../auth_bloc/auth_bloc.dart';
import '../theme/theme_toggle_icon.dart';
import 'profile_cubit/profile_cubit.dart';

/// 👤 [ProfilePage] — shows user profile details fetched from backend.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthBloc>().state.user?.uid;
    if (uid == null) return const SizedBox.shrink();

    return BlocProvider(
      create:
          (_) => ProfileCubit(profileRepository: di())..getProfile(uid: uid),
      child: const ProfileView(),
    );
  }
}

/// 📄 [ProfileView] — Handles state for loading, error, and loaded profile states.
class ProfileView extends StatelessWidget {
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
          if (state.profileStatus == ProfileStatus.error) {
            AppDialogs.showErrorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          switch (state.profileStatus) {
            case ProfileStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());

            case ProfileStatus.error:
              return const _ErrorContent();

            case ProfileStatus.loaded:
              return _UserProfileCard(user: state.user);

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

/// 🧾 [_UserProfileCard] — Displays user information after successful fetch.
class _UserProfileCard extends StatelessWidget {
  final User user;
  const _UserProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppSpacing.l),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: user.profileImage,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    '${AppStrings.profileNameLabel} ${user.name}',
                    TextType.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextWidget(
                    '${AppStrings.profileIdLabel} ${user.id}',
                    TextType.titleSmall,
                  ),
                  TextWidget(
                    '${AppStrings.profileEmailLabel} ${user.email}',
                    TextType.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextWidget(
                    '${AppStrings.profilePointsLabel} ${user.point}',
                    TextType.bodyMedium,
                  ),
                  TextWidget(
                    '${AppStrings.profileRankLabel} ${user.rank}',
                    TextType.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ⚠️ [_ErrorContent] — Shown when profile loading fails.
class _ErrorContent extends StatelessWidget {
  const _ErrorContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage('assets/images/error.png'), width: 75),
          SizedBox(height: AppSpacing.s),
          TextWidget(AppStrings.profileErrorMessage, TextType.error),
        ],
      ),
    );
  }
}
