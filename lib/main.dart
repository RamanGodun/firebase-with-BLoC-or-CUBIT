/*
 * Copyright (c) 2025 Roman Godun
 * All rights reserved, see [./LICENSE].
 * This software is proprietary and confidential.
 * Unauthorized copying, distribution, or use is strictly prohibited.
  
  For licensing inquiries, contact: 4l.roman.godun@gmail.com or godun.rm@gmail.com
 */

import 'package:flutter/material.dart';
import 'app_bootstrap_and_config/di_container/global_di_container.dart';
import 'core/base_modules/localization/core_of_module/localization_wrapper.dart';
import 'root_view_shell.dart';
import 'app_bootstrap_and_config/app_bootstrap/app_bootstrap.dart';

/// 🏁 Application entry point
//
void main() async {
  ///
  final appBootstrap = const AppBootstrap(
    // ? Here can be plugged in custom dependencies (e.g.  "localStorage: IsarLocalStorage()," )
  );

  /// 🚀 Runs all startup logic (localization, Firebase, DI container, debug tools, local storage, etc).
  await appBootstrap.initAllServices();

  /// 🏁 Launches app with all global Cubits/Blocs from DI.
  runApp(const GlobalProviders(child: AppLocalizationShell()));
  //
}

////

////

/// 🌍✅ [AppLocalizationShell] — Ensures the entire app tree is properly localized before rendering the root UI.
//
final class AppLocalizationShell extends StatelessWidget {
  ///----------------------------------------------
  const AppLocalizationShell({super.key});

  @override
  Widget build(BuildContext context) {
    //
    /// Injects localization context into the widget tree (provides all supported locales and translation assets)
    return LocalizationWrapper.configure(const AppRootViewShell());
  }
}
