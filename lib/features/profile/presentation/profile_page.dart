import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_bootstrap_and_config/di_container/di_container_initializaion.dart';
import '../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../core/base_modules/localization/widgets/_toggle_button.dart';
import '../../../core/base_modules/localization/widgets/key_value_x_for_text_w.dart';
import '../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../core/base_modules/theme/widgets_and_utils/blur_wrapper.dart';
import '../../../core/base_modules/theme/widgets_and_utils/theme_picking_widgets/theme_picker.dart';
import '../../../core/base_modules/theme/widgets_and_utils/theme_picking_widgets/widget_for_theme_toggling.dart';
import '../../../core/shared_presentation_layer/shared_widgets/buttons/filled_button.dart';
import '../../../app_bootstrap_and_config/firebase_config/user_auth_cubit/auth_cubit.dart';
import '../../../core/shared_domain_layer/shared_entities/_user_entity.dart';
import '../../../core/shared_presentation_layer/shared_widgets/app_bar.dart';
import '../../../core/shared_presentation_layer/shared_widgets/loader.dart';
import '../../../core/utils_shared/spider/images_paths.dart';
import '../../auth/presentation/sign_out/sign_out_cubit/sign_out_cubit.dart';
import '../../auth/presentation/sign_out/sign_out_widget.dart';
import 'cubit/profile_page_cubit.dart';

part 'widgets_for_profile_page.dart';

/// 👤 [ProfilePage] — Shows user profile details and allows sign-out
/// ✅ Uses [AuthCubit] to obtain UID and loads profile via [ProfileCubit]
/// ✅ Injects [SignOutCubit] to trigger logout
//
final class ProfilePage extends StatelessWidget {
  ///------------------------------------
  const ProfilePage({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    final uid = context.read<AuthCubit>().state.user?.uid;
    // 🛑 Guard: If user is not available, return empty widget
    if (uid == null) return const SizedBox.shrink();

    /// Profile loading if not have been done
    context.read<ProfileCubit>().loadProfile(uid);

    /// 🧩♻️ Injects [ProfileCubit] and [SignOutCubit] with DI and loads profile on init
    return BlocProvider<SignOutCubit>(
      create: (_) => di<SignOutCubit>(),

      /// Bloc listener for one-shot error feedback.
      /// Uses `Consumable<FailureUIModel>` for single-use error overlays.
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen:
            (prev, curr) => prev is! ProfileError && curr is ProfileError,

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
      ),
    );
  }
}

////

////

/// 📄 [ProfileView] — Handles state for loading, error, and loaded profile states
/// ✅ Reacts to [ProfileCubit] and shows appropriate UI

final class ProfileView extends StatelessWidget {
  ///------------------------------------------
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: const _ProfileAppBar(),

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder:
            (context, state) => switch (state) {
              ProfileInitial() => const SizedBox.shrink(),
              ProfileLoaded(:final user) => _UserProfileCard(user: user),

              ProfileLoading() =>
                const AppLoader(), // Show loader while data is loading

              ProfileError() =>
                const SizedBox.shrink(), // Show nothing, as overlay handles errors
            },
      ),
    );
  }
}
