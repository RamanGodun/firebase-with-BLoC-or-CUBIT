import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show MultiBlocProvider, BlocProvider;
import '../di_container/di_container.dart';
import '../../core/foundation/theme/_theme_preferences.dart';
import '../../core/foundation/theme/app_theme_variants.dart';
import '../../core/foundation/theme/text_theme/text_theme_factory.dart';
import '../../core/foundation/theme/theme_cubit.dart';
import '../../core/layers_shared/presentation_layer_shared/widgets_shared/loaders/loader.dart';

/// 🌳📦  [InitAppLoaderShell] provides the initial shell for the app loader
///       till the main app's bootstrap finish

final class InitAppLoaderShell extends StatelessWidget {
  ///
  /// Initial theme preferences for the loader shell.
  final ThemePreferences initialTheme;

  /// Creates the [InitAppLoaderShell] with an optional [initialTheme].
  /// If not provided, defaults to dark theme with SF Pro font.
  const InitAppLoaderShell({
    super.key,
    this.initialTheme = const ThemePreferences(
      theme: ThemeVariantsEnum.dark,
      font: AppFontFamily.sfPro,
    ),
  });

  @override
  Widget build(BuildContext context) {
    ///
    // Inject only the required Blocs for the loader phase.
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

/// 📱 [MaterialAppForInitLoader] creates a [MaterialApp] configured with the initial theme
///       for the app's loader/splash screen phase.
/// 🧱 This widget is used only during the minimal DI phase, before the full app is bootstrapped.

final class MaterialAppForInitLoader extends StatelessWidget {
  ///--------------------------------------------
  //
  final ThemePreferences initialTheme;
  const MaterialAppForInitLoader({super.key, required this.initialTheme});

  ///
  @override
  Widget build(BuildContext context) {
    ///
    // Configures the splash loader app with initial themes.
    return MaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: initialTheme.buildLight(),
      darkTheme: initialTheme.buildDark(),
      themeMode: initialTheme.mode,
      home: const Scaffold(body: AppLoader(size: 50)),
    );
  }
}
