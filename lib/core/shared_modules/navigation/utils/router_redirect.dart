import 'package:flutter/foundation.dart';
import '../../../../features/auth/presentation/auth_bloc/auth_bloc.dart';
import '../_imports_for_router.dart'; // для kDebugMode

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

  if (isUnknown) {
    final target = isSplash ? null : '/${RoutesNames.splash}';
    if (kDebugMode) {
      debugPrint('[🔁 Redirect] $currentPath → $target (authStatus: unknown)');
    }
    return target;
  }

  if (isUnauthenticated) {
    final target = isOnAuthPage ? null : '/${RoutesNames.signIn}';
    if (kDebugMode) {
      debugPrint(
        '[🔁 Redirect] $currentPath → $target (authStatus: unauthenticated)',
      );
    }
    return target;
  }

  if (isAuthenticated && (isSplash || isOnAuthPage)) {
    const target = '/${RoutesNames.home}';
    if (kDebugMode) {
      debugPrint(
        '[🔁 Redirect] $currentPath → $target (authStatus: authenticated)',
      );
    }
    return target;
  }

  if (kDebugMode) {
    debugPrint('[✅ No redirect] $currentPath (authStatus: $status)');
  }

  return null;
}
