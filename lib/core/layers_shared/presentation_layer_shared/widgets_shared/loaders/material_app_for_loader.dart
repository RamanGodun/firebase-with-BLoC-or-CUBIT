import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show MultiBlocProvider, BlocProvider;
import '../../../../modules_shared/di_container/di_container.dart';
import '../../../../modules_shared/theme/_theme_preferences.dart';
import '../../../../modules_shared/theme/app_theme_variants.dart';
import '../../../../modules_shared/theme/text_theme/text_theme_factory.dart';
import '../../../../modules_shared/theme/theme_cubit.dart';
import 'loader.dart';

/// 🌳📦 [InitAppLoaderShell] — Wraps global Blocs for app-wide access
final class InitAppLoaderShell extends StatelessWidget {
  ///--------------------------------------------

  final ThemePreferences initialTheme;
  const InitAppLoaderShell({
    super.key,
    this.initialTheme = const ThemePreferences(
      theme: ThemeVariantsEnum.dark,
      font: AppFontFamily.sfPro,
    ),
  });

  @override
  Widget build(BuildContext context) {
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AppThemeCubit>()),
        // BlocProvider(create: (_) => AppThemeCubit()),
      ],
      child: MaterialAppForInitLoader(initialTheme: initialTheme),
    );
  }

  //
}

/// 🌳📦📱🧱 [MaterialAppForInitLoader] — Wraps global Blocs for app-wide access

final class MaterialAppForInitLoader extends StatelessWidget {
  ///--------------------------------------------
  //
  final ThemePreferences initialTheme;
  const MaterialAppForInitLoader({super.key, required this.initialTheme});

  ///
  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: initialTheme.buildLight(),
      darkTheme: initialTheme.buildDark(),
      themeMode: initialTheme.mode,
      home: const Scaffold(body: AppLoader(size: 50)),
    );
  }
}
