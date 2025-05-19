import 'package:easy_localization/easy_localization.dart';
import '../core/app_localizer.dart';

/// 📌 Extension for `AppStrings.someKey.tl()` — translated localization
extension AppStringsTLX on String {
  /// 🔁 Safe `.tr()` with fallback to key itself
  String safeTr() {
    try {
      return this.tr();
    } catch (_) {
      return this; // fallback — повертає ключ
    }
  }

  /// 🧩 Translates via AppLocalizer with optional fallback
  String tl({String? fallback}) => AppLocalizer.t(this, fallback: fallback);

  /// 🧩 Translates with arguments (positional / named), fallback if error
  String tlArgs({
    String? fallback,
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    try {
      return this.tr(
        args: args ?? [],
        namedArgs: namedArgs ?? {},
        gender: gender,
      );
    } catch (_) {
      return fallback ?? this;
    }
  }
}
