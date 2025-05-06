import 'dart:convert';
import '../../../../core/utils/typedef.dart';

/// 🧩 [BaseDTO] — Abstract base class for all DTOs (Data Transfer Objects)
/// ✅ Provides shared serialization logic:
/// - `toMap()` for conversion to raw data
/// - `toJson()` for JSON encoding
/// - `fromJson()` for decoding with a mapper
//----------------------------------------------------------------

abstract class BaseDTO {
  const BaseDTO();

  /// 🔄 Converts object into a serializable [Map]
  DataMap toMap();

  /// 🧱 Converts object into a JSON string
  String toJson() => jsonEncode(toMap());

  /// 🧱 Constructs DTO from JSON string using a provided `fromMap` function
  static T fromJson<T extends BaseDTO>(
    String source,
    T Function(DataMap json) fromMap,
  ) {
    final map = jsonDecode(source) as DataMap;
    return fromMap(map);
  }

  ///
}
