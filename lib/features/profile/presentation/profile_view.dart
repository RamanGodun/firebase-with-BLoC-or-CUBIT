import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_config/spider/images_paths.dart';
import '../../../core/shared_modules/app_localization/code_base_for_both_options/key_value_x_for_text_w.dart';
import '../../../core/shared_modules/app_localization/generated/locale_keys.g.dart';
import '../../../core/shared_modules/app_localization/language_toggle_widget/toggle_button.dart';
import '../../../core/shared_presentation/constants/_app_constants.dart'
    show AppSpacing;
import '../../../core/shared_presentation/shared_widgets/app_loaders.dart';
import '../../shared/shared_domain/shared_entities/_user.dart';
import '../../../core/shared_presentation/shared_widgets/custom_app_bar.dart';
import '../../../core/shared_modules/app_localization/code_base_for_both_options/text_widget.dart';
import '../../../core/shared_modules/app_theme/theme_toggle_widget.dart';
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
      ///
      appBar:
      ///
      const CustomAppBar(
        title: LocaleKeys.pages_profile,
        actionWidgets: [ThemeToggleIcon(), LanguageToggleButton()],
      ),

      ///
      body:
      ///
      BlocBuilder<ProfileCubit, ProfileState>(
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
