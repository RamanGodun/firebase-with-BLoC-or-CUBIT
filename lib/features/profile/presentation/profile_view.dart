import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/modules_shared/theme/theme_utils/blur_wrapper.dart';
import '../../../core/utils_shared/spider/images_paths.dart';
import '../../../core/modules_shared/localization/widgets/key_value_x_for_text_w.dart';
import '../../../core/modules_shared/localization/generated/locale_keys.g.dart';
import '../../../core/modules_shared/localization/widgets/_toggle_button.dart';
import '../../../core/modules_shared/theme/core/constants/_app_constants.dart'
    show AppSpacing, AppIcons;
import '../../../core/layers_shared/presentation_layer_shared/widgets_shared/app_loaders.dart';
import '../../auth/presentation/sign_out/sign_out_cubit/sign_out_cubit.dart';
import '../domain/shared_entities/_user.dart';
import '../../../core/layers_shared/presentation_layer_shared/widgets_shared/custom_app_bar.dart';
import '../../../core/modules_shared/localization/widgets/text_widget.dart';
import '../../../core/modules_shared/theme/widget_for_theme_toggling.dart';
import 'cubit/profile_page_cubit.dart';

part 'widgets_for_profile_view.dart';

/// 📄 [ProfileView] — Handles state for loading, error, and loaded profile states
/// ✅ Reacts to [ProfileCubit] and shows appropriate UI

final class ProfileView extends StatelessWidget {
  //--------------------------------------------

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.pages_profile,
        actionWidgets: [
          const ThemeToggleIcon(),
          const LanguageToggleButton(),
          IconButton(
            icon: const Icon(AppIcons.logout),
            onPressed: () => context.read<SignOutCubit>().signOut(),
          ),
        ],
      ),

      ///
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder:
            (context, state) => switch (state) {
              ProfileInitial() => const SizedBox.shrink(),
              ProfileLoading() => const LoaderWidget(),
              ProfileError() => const _ErrorContent(),
              ProfileLoaded(:final user) => _UserProfileCard(user: user),
            },
      ),
    );
  }
}
