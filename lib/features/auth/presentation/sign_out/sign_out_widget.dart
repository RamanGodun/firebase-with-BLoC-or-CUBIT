import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/modules_shared/theme/core/constants/_app_constants.dart';
import 'sign_out_cubit/sign_out_cubit.dart';

class SignOutWidget extends StatelessWidget {
  ///--------------------------------------
  const SignOutWidget({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    return IconButton(
      icon: const Icon(AppIcons.logout),
      onPressed: () => context.read<SignOutCubit>().signOut(),
    ).withPaddingOnly(right: AppSpacing.m);
  }
}
