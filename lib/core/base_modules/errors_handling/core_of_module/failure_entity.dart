import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show sealed;
import 'failure_type.dart';

/// 🧩 [Failure] — Domain-layer error representation.
/// ✅ Encapsulates structured error data
/// ✅ Used throughout layers (repo → use case → UI)
/// ✅ Supports localized display and diagnostics fallback
///
@sealed
final class Failure extends Equatable {
  // 🧩 Structured metadata (i18n key, code)
  final FailureType type;
  // 💬 Optional raw error message (e.g. Dio/Firebase message) for fallback when there is no localization in app
  final String? message;
  // 🔢 Optional HTTP or platform status code
  final int? statusCode;

  /// 🔒 Private constructor to ensure factory usage only
  const Failure({
    required this.type,
    @pragma('vm:entry-point') this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [type, message, statusCode];

  /// 🪪 For diagnostics — fallback code representation
  String get safeCode => statusCode?.toString() ?? type.code;
}
