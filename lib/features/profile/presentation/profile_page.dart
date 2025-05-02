import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/constants/app_constants.dart' show AppSpacing;
import '../../../core/presentation/constants/app_strings.dart';
import '../../../core/app_config/bootstrap/di_container.dart';
import '../../shared/shared_domain/entities/user.dart';
import '../../../core/shared_moduls/overlay/_overlay_service.dart';
import '../../../core/presentation/shared_widgets/custom_app_bar.dart';
import '../../../core/presentation/shared_widgets/text_widget.dart';
import '../../auth/presentation/auth/auth_bloc/auth_bloc.dart';
import '../../../core/shared_moduls/theme/theme_toggle_widget.dart';
import 'profile_cubit/profile_cubit.dart';

/// 👤 [ProfilePage] — shows user profile details fetched from backend.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthBloc>().state.user?.uid;
    if (uid == null) return const SizedBox.shrink();

    return BlocProvider(
      create: (_) => ProfileCubit(di())..loadProfile(uid),
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
          if (state.status == ProfileStatus.error && state.failure != null) {
            OverlayNotificationService.dismissIfVisible();
            context.showFailureDialog(state.failure!);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ProfileStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());

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
