import '../../features/auth_bloc/auth_bloc.dart';
import '_imports_for_router.dart';

/// 🔁 Handles auth-aware redirect logic for GoRouter
String? handleAuthRedirect({
  required AuthBloc authBloc,
  required String currentPath,
}) {
  final status = authBloc.state.authStatus;

  final isAuthenticated = status == AuthStatus.authenticated;
  final isUnauthenticated = status == AuthStatus.unauthenticated;
  final isUnknown = status == AuthStatus.unknown;

  final isSplash = currentPath == '/${RoutesNames.splash}';
  final isOnAuthPage = [
    '/${RoutesNames.signIn}',
    '/${RoutesNames.signUp}',
    '/${RoutesNames.resetPassword}',
  ].contains(currentPath);

  if (isUnknown) return isSplash ? null : '/${RoutesNames.splash}';
  if (isUnauthenticated) return isOnAuthPage ? null : '/${RoutesNames.signIn}';
  if (isAuthenticated && (isSplash || isOnAuthPage)) {
    return '/${RoutesNames.home}';
  }

  return null;
}
