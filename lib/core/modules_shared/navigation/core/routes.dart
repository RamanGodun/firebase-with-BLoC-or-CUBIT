import 'package:go_router/go_router.dart';
import '../../../../features/auth/presentation/sign_in/sign_in_page.dart';
import '../../../../features/auth/presentation/sign_up/sign_up_page.dart';
import '../../../../features/profile/presentation/profile_page.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/_home_page.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/change_password_page.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/password_reset_page.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/splash_page.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/verify_email_page.dart';
import 'routes_names.dart';
import '../utils/page_transition.dart';

/// 🧭 [AppRoutes] — Centralized list of all GoRouter routes
/// ✅ Used in [goRouter] and matches [RoutesNames]

final class AppRoutes {
  ///-----------------
  const AppRoutes._();

  ///

  static final List<RouteBase> all = [
    /// ⏳ Splash Page
    GoRoute(
      path: '/${RoutesNames.splash}',
      name: RoutesNames.splash,
      pageBuilder: (_, _) => AppTransitions.fade(const SplashPage()),
    ),

    /// 🏠 Home Page
    GoRoute(
      path: '/home',
      name: RoutesNames.home,
      pageBuilder: (context, state) => AppTransitions.fade(const HomePage()),
      routes: [
        /// 👤 Profile Page (Nested under Home)
        GoRoute(
          path: 'profile',
          name: RoutesNames.profile,
          pageBuilder:
              (context, state) => AppTransitions.fade(const ProfilePage()),
          routes: [
            /// 👤  Change password Page (Nested under Profile page)
            GoRoute(
              path: 'profile/changePassword',
              name: RoutesNames.changePassword,
              // builder: (context, state) => const ChangePasswordPage(),
              pageBuilder:
                  (context, state) =>
                      AppTransitions.fade(const ChangePasswordPage()),
            ),
          ],
        ),
      ],
    ),

    /// 🔐 Auth Pages
    GoRoute(
      path: '/${RoutesNames.signIn}',
      name: RoutesNames.signIn,
      pageBuilder: (context, state) => AppTransitions.fade(const SignInPage()),
    ),

    GoRoute(
      path: '/${RoutesNames.signUp}',
      name: RoutesNames.signUp,
      pageBuilder: (context, state) => AppTransitions.fade(const SignUpPage()),
    ),

    GoRoute(
      path: '/${RoutesNames.resetPassword}',
      name: RoutesNames.resetPassword,
      pageBuilder:
          (context, state) => AppTransitions.fade(const ResetPasswordPage()),
    ),

    GoRoute(
      path: '/${RoutesNames.verifyEmail}',
      name: RoutesNames.verifyEmail,
      pageBuilder:
          (context, state) => AppTransitions.fade(const VerifyEmailPage()),
    ),

    ///

    /// ❌ Error / 404 Page
    GoRoute(
      path: '/${RoutesNames.pageNotFound}',
      name: RoutesNames.pageNotFound,
      pageBuilder:
          (context, state) => AppTransitions.fade(
            const PageNotFound(errorMessage: 'Page not found'),
          ),
    ),

    //
  ];

  //
}
