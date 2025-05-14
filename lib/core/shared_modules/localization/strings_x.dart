import 'package:easy_localization/easy_localization.dart';

import 'localizer.dart';

/// 📌 Extension for `AppStrings.someKey.tl()` — translated localization
extension AppStringsTLX on String {
  ///
  String safeTr() {
    try {
      return this.tr();
    } catch (_) {
      return this; // fallback — повертає ключ
    }
  }

  /// 🧩 Translates via AppLocalizer.t(...) with fallback support
  String tl({String? fallback}) => AppLocalizer.t(this, fallback: fallback);
  //
}
