import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class OverlayMessageKey {
  /// Ключ перекладу (наприклад, 'overlay.error.timeout')
  String get translationKey;

  /// Значення за замовчуванням (наприклад, 'Something went wrong')
  String get fallback;

  /// Аргументи для локалізації (якщо потрібно)
  Map<String, String> get params;

  /// Викликає переклад відповідно до EasyLocalization
  String localize(BuildContext context) => translationKey.tr(namedArgs: params);

  @override
  String toString() => 'OverlayMessageKey($translationKey)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverlayMessageKey &&
          runtimeType == other.runtimeType &&
          translationKey == other.translationKey &&
          fallback == other.fallback &&
          _mapEquals(params, other.params);

  @override
  int get hashCode =>
      translationKey.hashCode ^ fallback.hashCode ^ params.hashCode;
}

class StaticOverlayMessageKey extends OverlayMessageKey {
  @override
  final String translationKey;

  @override
  final String fallback;

  @override
  final Map<String, String> params;

  StaticOverlayMessageKey(
    this.translationKey, {
    required this.fallback,
    this.params = const {},
  });
}

// 🔖 Популярні pre-defined ключі для UI/UX-повідомлень
sealed class OverlayMessageKeys {
  static final unexpected = StaticOverlayMessageKey(
    'overlay.error.unexpected',
    fallback: 'Something went wrong',
  );

  static final noInternet = StaticOverlayMessageKey(
    'overlay.error.no_internet',
    fallback: 'No internet connection',
  );

  static final timeout = StaticOverlayMessageKey(
    'overlay.error.timeout',
    fallback: 'Request timeout. Try again.',
  );

  static final saved = StaticOverlayMessageKey(
    'overlay.success.saved',
    fallback: 'Saved successfully',
  );

  static final deleted = StaticOverlayMessageKey(
    'overlay.success.deleted',
    fallback: 'Item deleted',
  );
}

bool _mapEquals(Map<String, String> a, Map<String, String> b) {
  if (a.length != b.length) return false;
  for (final key in a.keys) {
    if (a[key] != b[key]) return false;
  }
  return true;
}
