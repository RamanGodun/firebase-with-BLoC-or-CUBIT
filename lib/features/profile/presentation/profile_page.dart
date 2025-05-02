import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_config/bootstrap/di_container.dart';
import '../../auth/presentation/auth_bloc/auth_bloc.dart';
import 'cubit/profile_page_cubit.dart';
import 'profile_view.dart';

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
