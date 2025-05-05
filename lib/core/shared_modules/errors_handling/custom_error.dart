import 'package:equatable/equatable.dart';

/// 🔌 [ErrorPlugin] — Identifies the source of a [CustomError].
/// 🧭 Useful for analytics, diagnostics, and categorizing error origins.

enum ErrorPlugin {
  httpClient,
  firebase,
  sqlite,
  useCase,
  unknown;

  String get code => switch (this) {
    httpClient => 'HTTP_CLIENT',
    firebase => 'FIREBASE',
    sqlite => 'SQLITE',
    useCase => 'USE_CASE',
    unknown => 'UNKNOWN',
  };
}

//----------------------------------------------------------------------------------

/// 💥 [CustomError] — Encapsulates platform, SDK, or domain-level error information.
/// 🧼 Designed for safe transport of error data between layers (Data → Domain → UI).

class CustomError extends Equatable {
  final String code;
  final String message;
  final ErrorPlugin plugin;

  const CustomError({
    required this.code,
    required this.message,
    required this.plugin,
  });

  /// 🪙 Fallback for unmapped errors.
  factory CustomError.unknown([String? rawError]) => CustomError(
    code: 'UNKNOWN',
    message: rawError ?? 'An unknown error occurred',
    plugin: ErrorPlugin.unknown,
  );

  ///
  CustomError copyWith({String? code, String? message, ErrorPlugin? plugin}) {
    return CustomError(
      code: code ?? this.code,
      message: message ?? this.message,
      plugin: plugin ?? this.plugin,
    );
  }

  ///
  @override
  List<Object?> get props => [code, message, plugin];

  ///
}
