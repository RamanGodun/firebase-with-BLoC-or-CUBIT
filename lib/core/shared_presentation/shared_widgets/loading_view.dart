import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';

/// ⏳ [LoadingView] — Semi-transparent fullscreen loading indicator
//----------------------------------------------------------------

final class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child:
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              context.theme.colorScheme.secondary,
            ),
          ).centered(),
    );
  }
}
