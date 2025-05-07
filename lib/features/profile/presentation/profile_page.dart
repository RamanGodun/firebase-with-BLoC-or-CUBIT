import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_config/bootstrap/di_container.dart';
import '../../../core/utils/failure_notifier.dart';
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

/// 🔁 [_ProfileListenerWrapper] — Listens for one-shot profile errors
/// ✅ Shows error overlay and clears failure from Bloc state
//----------------------------------------------------------------

final class _ProfileListenerWrapper extends StatelessWidget {
  const _ProfileListenerWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      ///
      listenWhen:
          (prev, curr) =>
              prev.status != curr.status && curr.status == ProfileStatus.error,

      // 📣 Shows error dialog once and clears failure from state
      listener: (context, state) {
        FailureNotifier.handle(context, state.failure);
        context.read<ProfileCubit>().clearFailure();
      },

      ///
      child: const ProfileView(),
    );
  }
}
