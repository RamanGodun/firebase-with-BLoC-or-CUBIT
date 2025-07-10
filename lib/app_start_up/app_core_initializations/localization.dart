import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../../core/foundation/localization/app_localizer.dart';

/// 🌍 [ILocalizationStack] — abstraction for localization engine initialization.
/// ✅ Used to decouple localization logic and enable mocking/testing.

abstract interface class ILocalizationStack {
  ///-------------------------------------
  //
  /// Initializes all localization services (EasyLocalization, custom localizer)
  Future<void> init();
  //
}

////

////

/// 🌍 [LocalizationStack] — [ILocalizationStack] implementation.

final class LocalizationStack implements ILocalizationStack {
  ///------------------------------------------------------------
  const LocalizationStack();

  ///
  @override
  Future<void> init() async {
    //
    debugPrint('🌍 Initializing EasyLocalization...');
    // ✅🌍 Ensures EasyLocalization is initialized before runApp
    await EasyLocalization.ensureInitialized();

    // 🌍 Sets up the global localization resolver for the app
    // ? when app with localization, use this:
    AppLocalizer.init(resolver: (key) => key.tr());
    // ? when app without localization, then instead previous method use next:
    // AppLocalizer.initWithFallback();
    debugPrint('🌍 EasyLocalization initialized!');

    //
  }
}
