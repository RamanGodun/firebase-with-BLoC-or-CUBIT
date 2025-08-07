import 'package:flutter/material.dart';

/// 👁️ Shared password visibility icon
//
final class ObscureToggleIcon extends StatelessWidget {
  ///-----------------------------------------------
  //
  final bool isObscure;
  final VoidCallback onPressed;

  const ObscureToggleIcon({
    super.key,
    required this.isObscure,
    required this.onPressed,
  });

  ///

  @override
  Widget build(BuildContext context) {
    //
    return IconButton(
      icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
      onPressed: onPressed,
    );
  }
}
