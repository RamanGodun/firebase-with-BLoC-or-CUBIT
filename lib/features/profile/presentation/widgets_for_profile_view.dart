part of 'profile_view.dart';

/// 🧾 [_UserProfileCard] — Displays user information after successful fetch.
//----------------------------------------------------------------

final class _UserProfileCard extends StatelessWidget {
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
            placeholder: ImagesPaths.loading,
            image: user.profileImage,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 👤 Name
                  KeyValueTextWidget(
                    labelKey: LocaleKeys.profile_name,
                    value: user.name,
                    labelTextType: TextType.bodySmall,
                  ),

                  /// 🆔 ID
                  KeyValueTextWidget(
                    labelKey: LocaleKeys.profile_id,
                    value: user.id,
                    labelTextType: TextType.bodySmall,
                    valueTextType: TextType.bodySmall,
                  ),

                  /// 📧 Email
                  KeyValueTextWidget(
                    labelKey: LocaleKeys.profile_email,
                    value: user.email,
                    labelTextType: TextType.bodySmall,
                  ),

                  /// 📊 Points
                  KeyValueTextWidget(
                    labelKey: LocaleKeys.profile_points,
                    value: user.point.toString(),
                    labelTextType: TextType.bodySmall,
                  ),

                  /// 🏆 Rank
                  KeyValueTextWidget(
                    labelKey: LocaleKeys.profile_rank,
                    value: user.rank,
                    labelTextType: TextType.bodySmall,
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
//----------------------------------------------------------------

final class _ErrorContent extends StatelessWidget {
  const _ErrorContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage(ImagesPaths.error), width: 75),
          SizedBox(height: AppSpacing.s),
          TextWidget(LocaleKeys.profile_error, TextType.error),
        ],
      ),
    );
  }
}
