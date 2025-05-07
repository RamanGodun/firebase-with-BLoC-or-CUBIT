import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_config/bootstrap/di_container.dart';
import '../../../core/shared_modules/overlay/_overlay_service.dart';
import '../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../domain/load_profile_use_case.dart';
import 'cubit/profile_page_cubit.dart';
import 'profile_view.dart';

/// 👤 [ProfilePage] — Shows user profile details fetched from backend
/// ✅ Uses [AuthBloc] to obtain UID and loads profile via [ProfileCubit]
//----------------------------------------------------------------

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final uid = context.read<AuthBloc>().state.user?.uid;
    // 🛑 Guard: If user is not available, return empty widget
    if (uid == null) return const SizedBox.shrink();

    // 🧩 Injects [ProfileCubit] with DI and loads profile on init
    return BlocProvider(
      create: (_) => ProfileCubit(di<LoadProfileUseCase>())..loadProfile(uid),
      child: const _ProfileListenerWrapper(),
    );
  }
}

/// 🔁 [_ProfileListenerWrapper] — Handles failure overlays for [ProfileCubit]
/// ✅ Wraps [ProfileView] and listens for side-effects like errors
//----------------------------------------------------------------

final class _ProfileListenerWrapper extends StatelessWidget {
  const _ProfileListenerWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        final failure = state.failure?.consume();
        if (state.status == ProfileStatus.error && failure != null) {
          OverlayNotificationService.dismissIfVisible();
          context.showFailureDialog(failure);
          context.read<ProfileCubit>().clearFailure();
        }
      },
      child: const ProfileView(),
    );
  }
}
