import 'dart:convert';
import '../../../core/utils_and_services/errors_handling/typedef.dart';

/// 🧩 [BaseDTO] — базовий клас для всіх DTO
/// 🧼 Надає `toJson()`, `toMap()` та `fromJson(String)` загалом
//----------------------------------------------------------------//
abstract class BaseDTO {
  const BaseDTO();

  /// 🔄 Перетворює обʼєкт у Map
  DataMap toMap();

  /// 🧱 Перетворює у JSON-строку
  String toJson() => jsonEncode(toMap());

  /// 🧱 Перетворює із JSON-строки
  static T fromJson<T extends BaseDTO>(
    String source,
    T Function(DataMap json) fromMap,
  ) {
    final map = jsonDecode(source) as DataMap;
    return fromMap(map);
  }
}
