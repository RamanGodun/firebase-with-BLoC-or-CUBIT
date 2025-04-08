import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_error.freezed.dart';

/// **Custom Error Model**
///
/// This model represents a standardized error format used across the app.
/// It encapsulates essential error details such as:
/// - `code`: A unique identifier for the error.
/// - `message`: A human-readable description of the error.
/// - `plugin`: The source of the error (e.g., Firebase, API, Local Storage).
///
/// ✅ Uses [Freezed](https://pub.dev/packages/freezed) for immutability,
/// data equality, and sealed union functionality.
@freezed
class CustomError with _$CustomError {
  /// **Factory Constructor**
  ///
  /// Initializes a `CustomError` instance with default values if not provided.
  const factory CustomError({
    @Default('') String code, // Unique error code
    @Default('') String message, // Error message
    @Default('') String plugin, // Source of the error (e.g., Firebase)
  }) = _CustomError;
}
