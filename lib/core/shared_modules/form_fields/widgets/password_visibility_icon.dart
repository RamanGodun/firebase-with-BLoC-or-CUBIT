import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/presentation/sign_up/cubit/sign_up_page_cubit.dart';

/// 👁️ Shared password visibility icon with selector
class ObscureToggleIcon extends StatelessWidget {
  final bool Function(SignUpState state) selector;
  final VoidCallback onPressed;

  const ObscureToggleIcon({
    super.key,
    required this.selector,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, bool>(
      selector: selector,
      builder: (context, isObscure) {
        return IconButton(
          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: onPressed,
        );
      },
    );
  }
}
