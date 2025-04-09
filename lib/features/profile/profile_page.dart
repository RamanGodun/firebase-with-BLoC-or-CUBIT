import 'package:firebase_with_bloc_or_cubit/presentation/widgets/custom_app_bar.dart';
import 'package:firebase_with_bloc_or_cubit/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection.dart';
import '../../core/entities/user_model.dart';
import '../../core/utils_and_services/errors_handling/error_dialog.dart';
import '../auth_bloc/auth_bloc.dart';
import 'profile_cubit/profile_cubit.dart';
import '../theme/theme_toggle_icon.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthBloc>().state.user?.uid;
    if (uid == null) return const SizedBox.shrink();

    return BlocProvider(
      create:
          (_) =>
              ProfileCubit(profileRepository: appSingleton())
                ..getProfile(uid: uid),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        actionWidgets: [ThemeToggleIcon()],
      ),

      ///
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.error) {
            AppDialogs.showErrorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          switch (state.profileStatus) {
            case ProfileStatus.loading:
              return const Center(child: CircularProgressIndicator());

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

/// 🔻 User UI
class _UserProfileCard extends StatelessWidget {
  final User user;
  const _UserProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
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
            padding: const EdgeInsets.all(16),
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget('👤 Name: ${user.name}', TextType.titleMedium),
                  const SizedBox(height: 5),
                  TextWidget('🆔 ID: ${user.id}', TextType.titleSmall),
                  TextWidget('📧 Email: ${user.email}', TextType.titleSmall),
                  const SizedBox(height: 16),
                  TextWidget('📊 Points: ${user.point}', TextType.bodyMedium),
                  TextWidget('🏆 Rank: ${user.rank}', TextType.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔻 Error State UI
class _ErrorContent extends StatelessWidget {
  const _ErrorContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/error.png', width: 75),
          const SizedBox(height: 12),
          const TextWidget('Oops!\nSomething went wrong.', TextType.error),
        ],
      ),
    );
  }
}
