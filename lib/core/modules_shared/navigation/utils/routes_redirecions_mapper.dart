abstract final class AuthRedirectMapper {
  ///-----------------------------------

  static String? from({
    required bool isAuthenticated,
    required bool isVerified,
    required bool isLoading,
    required bool isError,
    required String currentPath,
  }) {
    const publicRoutes = {'/signin', '/signup', '/resetPassword'};

    if (isLoading) return '/splash';
    if (isError) return '/firebaseError';

    final isOnPublic = publicRoutes.contains(currentPath);
    final isOnSplash = currentPath == '/splash';
    final isOnVerify = currentPath == '/verifyEmail';

    if (!isAuthenticated) return isOnPublic ? null : '/signin';
    if (!isVerified) return isOnVerify ? null : '/verifyEmail';
    if (isOnPublic || isOnSplash || isOnVerify) return '/home';

    return null;
  }

  //
}
