import 'package:flutter/widgets.dart';

/// 🧩 [AppLocalizations] — temporary placeholder for future EasyLocalization support.
/// ✅ Prevents `undefined` errors before localization is added.
/// ✅ Imitates `.of(context).translate(key)` API
// ---------------------------------------------------------------------------
final class AppLocalizations {
  const AppLocalizations();

  static AppLocalizations? of(BuildContext context) {
    return const AppLocalizations();
  }

  /// Stub method — in production this will come from `easy_localization`
  String? translate(String key, [Map<String, String>? params]) {
    // 🔄 Later, this would call context.tr(key) via easy_localization
    return null;
  }
}
