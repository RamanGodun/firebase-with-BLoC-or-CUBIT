import 'package:equatable/equatable.dart';

/// ❌ [CustomError] — domain error model for unified exception handling
/// 🧼 Wraps platform-specific and Firebase errors into a consistent object
//----------------------------------------------------------------//
class CustomError extends Equatable {
  //
  final String code;
  final String message;
  final String plugin;

  const CustomError({this.code = '', this.message = '', this.plugin = ''});

  /// 🧱 Create new copy with optional overrides
  CustomError copyWith({String? code, String? message, String? plugin}) {
    return CustomError(
      code: code ?? this.code,
      message: message ?? this.message,
      plugin: plugin ?? this.plugin,
    );
  }

  @override
  List<Object?> get props => [code, message, plugin];

  //
}
