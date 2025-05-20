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
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    '${LocaleKeys.profile_name} ${user.name}',
                    TextType.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextWidget(
                    '${LocaleKeys.profile_id} ${user.id}',
                    TextType.titleSmall,
                  ),
                  TextWidget(
                    '${LocaleKeys.profile_email} ${user.email}',
                    TextType.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextWidget(
                    '${LocaleKeys.profile_points} ${user.point}',
                    TextType.bodyMedium,
                  ),
                  TextWidget(
                    '${LocaleKeys.profile_rank} ${user.rank}',
                    TextType.bodyMedium,
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
