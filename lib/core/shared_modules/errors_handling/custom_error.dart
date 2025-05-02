import 'package:equatable/equatable.dart';

/// 🔌 [ErrorPlugin] — source of the error (used for analytics, diagnostics)
/// 🧼 Provides context for where the error originated
//----------------------------------------------------------------//
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

/// 🧩 [CustomError] — internal representation of platform or API errors
/// 🧼 Safely carries error metadata across layers
//----------------------------------------------------------------//
class CustomError extends Equatable {
  final String code;
  final String message;
  final ErrorPlugin plugin;

  const CustomError({
    required this.code,
    required this.message,
    required this.plugin,
  });

  factory CustomError.unknown([String? rawError]) => CustomError(
    code: 'UNKNOWN',
    message: rawError ?? 'An unknown error occurred',
    plugin: ErrorPlugin.unknown,
  );

  CustomError copyWith({String? code, String? message, ErrorPlugin? plugin}) {
    return CustomError(
      code: code ?? this.code,
      message: message ?? this.message,
      plugin: plugin ?? this.plugin,
    );
  }

  @override
  List<Object?> get props => [code, message, plugin];
}
