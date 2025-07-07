import 'package:flutter/foundation.dart' show debugPrint;
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;

/// 🌐 [IOthersBootstrap] — abstraction for miscellaneous startup logic.
/// ✅ Used for things like URL strategy, app-wide initializations, etc.

abstract interface class IOthersBootstrap {
  ///-----------------------------------
  //
  /// Initializes misc startup logic (e.g., URL strategy for web)
  void initUrlStrategy();
  //
}

////

/// 🌐 [DefaultOthersBootstrap] — implementation of [IOthersBootstrap].

final class DefaultOthersBootstrap implements IOthersBootstrap {
  ///----------------------------------------------------
  const DefaultOthersBootstrap();
  //

  /// ✅ Removes `#` from web URLs for cleaner routing (Flutter web).
  @override
  void initUrlStrategy() {
    debugPrint('🌐 Setting path URL strategy...');
    setPathUrlStrategy();
    debugPrint('🌐 Path URL strategy set (no # in web URLs)');
  }

  /// Add other misc app-wide initializations here if needed.
  //
}
