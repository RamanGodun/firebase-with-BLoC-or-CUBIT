import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../core/base_modules/theme/theme_cubit.dart';
import '../../core/utils_shared/auth_state/auth_cubit.dart';
import '../../features/email_verification/presentation/email_verification_cubit/email_verification_cubit.dart';
import '../../features/profile/presentation/cubit/profile_page_cubit.dart';
import 'di_container_initializaion.dart';

/// 📦 [GlobalProviders] — Wraps all global Blocs with providers for the app
//
final class GlobalProviders extends StatelessWidget {
  ///---------------------------------------------
  //
  final Widget child;
  const GlobalProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AppThemeCubit>()),
        BlocProvider.value(value: di<OverlayStatusCubit>()),

        BlocProvider.value(value: di<AuthCubit>()),
        BlocProvider.value(value: di<ProfileCubit>()),

        BlocProvider.value(value: di<EmailVerificationCubit>()),

        // others...
      ],
      child: child,
    );
  }
}
