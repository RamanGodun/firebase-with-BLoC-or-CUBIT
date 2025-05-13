import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';

final class AppLoader extends StatelessWidget {
  final TargetPlatform platform;
  const AppLoader({required this.platform, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (platform) {
      TargetPlatform.android => Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            shape: BoxShape.circle,
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: const CircularProgressIndicator(),
        ),
      ),
      TargetPlatform.iOS => Center(
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
      _ => const CircularProgressIndicator.adaptive().centered(),
    };
  }
}
