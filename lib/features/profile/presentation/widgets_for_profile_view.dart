part of 'profile_view.dart';

/// 🧾 [_UserProfileCard] — Displays user information after successful fetch.
//
final class _UserProfileCard extends StatelessWidget {
  ///-----------------------------------------------

  final UserEntity user;
  const _UserProfileCard({required this.user});
  //

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: BlurContainer(
        child: Card(
          margin: const EdgeInsets.all(AppSpacing.xxm),
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage.assetNetwork(
                placeholder: AppImagesPaths.loading,
                image: user.profileImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 👤 Name
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_name,
                      value: user.name,
                      labelTextType: TextType.bodyMedium,
                      valueTextType: TextType.titleMedium,
                    ),

                    /// 🆔 ID
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_id,
                      value: user.id,
                      labelTextType: TextType.bodyMedium,
                      valueTextType: TextType.bodySmall,
                    ),

                    /// 📧 Email
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_email,
                      value: user.email,
                      labelTextType: TextType.bodyMedium,
                      valueTextType: TextType.titleSmall,
                    ),

                    /// 📊 Points
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_points,
                      value: user.point.toString(),
                      labelTextType: TextType.bodyMedium,
                    ),

                    /// 🏆 Rank
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_rank,
                      value: user.rank,
                      labelTextType: TextType.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    ///
                    const _ThemeSection(),
                    const SizedBox(height: AppSpacing.xl),

                    // const _ChangePasswordButton(),
                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ).withPaddingOnly(bottom: AppSpacing.huge),
    );
  }
}

////

////

/// ⚠️ [_ErrorContent] — Shown when profile loading fails.

final class _ErrorContent extends StatelessWidget {
  ///--------------------------------------------
  const _ErrorContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage(AppImagesPaths.error), width: 75),
          SizedBox(height: AppSpacing.xxxs),
          TextWidget(LocaleKeys.profile_error, TextType.error),
        ],
      ),
    );
  }
}

////

////

/// 🎨 [_ThemeSection] — UI section for selecting app theme and toggling appearance.
//
final class _ThemeSection extends StatelessWidget {
  const _ThemeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          LocaleKeys.theme_choose_theme.tr(),
          TextType.titleMedium,
          fontWeight: FontWeight.w700,
        ),
        Row(
          children: [
            ThemePicker(
              key: ValueKey(Localizations.localeOf(context).languageCode),
            ),
            const ThemeTogglerIcon().withPaddingOnly(left: AppSpacing.l),
          ],
        ),
      ],
    );
  }
}

////

////

/// 🔒 [_ChangePasswordButton] — Navigates user to Change Password screen.
//
// final class _ChangePasswordButton extends StatelessWidget {
//   const _ChangePasswordButton();

//   @override
//   Widget build(BuildContext context) {
//     return CustomFilledButton(
//       onPressed: () => context.goTo(RoutesNames.changePassword),
//       label: LocaleKeys.change_password_title,
//     );
//   }
// }
