import 'package:firebase_with_bloc_or_cubit/core/modules_shared/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/modules_shared/di_container/di_container.dart';
import '../../../core/layers_shared/domain_shared/auth_state_cubit/auth_cubit.dart';
import '../../auth/presentation/sign_out/sign_out_cubit/sign_out_cubit.dart';
import '../domain/load_profile_use_case.dart';
import 'cubit/profile_page_cubit.dart';
import 'profile_view.dart';

/// 👤 [ProfilePage] — Shows user profile details and allows sign-out
/// ✅ Uses [AuthCubit] to obtain UID and loads profile via [ProfileCubit]
/// ✅ Injects [SignOutCubit] to trigger logout

class ProfilePage extends StatelessWidget {
  //--------------------------------------

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final uid = context.read<AuthCubit>().state.user?.uid;
    // 🛑 Guard: If user is not available, return empty widget
    if (uid == null) return const SizedBox.shrink();

    /// 🧩♻️ Injects [ProfileCubit] and [SignOutCubit] with DI and loads profile on init
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => ProfileCubit(di<LoadProfileUseCase>())..loadProfile(uid),
        ),
        BlocProvider(create: (_) => di<SignOutCubit>()),
      ],
      child: const _ProfileListenerWrapper(),
    );
  }
}

////

////

/// 🔄 [_ProfileListenerWrapper] — Bloc listener for one-shot error feedback.
/// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.

final class _ProfileListenerWrapper extends StatelessWidget {
  //--------------------------------------------------------

  const _ProfileListenerWrapper();

  @override
  Widget build(BuildContext context) {
    //
    return BlocListener<ProfileCubit, ProfileState>(
      ///
      listenWhen: (prev, curr) => prev is! ProfileError && curr is ProfileError,

      /// 📣 Show error once and reset failure
      listener: (context, state) {
        if (state is ProfileError) {
          final model = state.failure.consume();
          if (model != null) {
            context.showError(model);
            context.read<ProfileCubit>().clearFailure();
          }
        }
      },

      ///
      child: const ProfileView(),
    );
  }
}
