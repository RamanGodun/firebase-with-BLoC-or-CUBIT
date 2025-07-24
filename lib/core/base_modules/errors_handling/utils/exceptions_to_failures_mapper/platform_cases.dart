part of '_exceptions_to_failures_mapper.dart';

/// ⚙️ [_handlePlatform] — maps [PlatformException] to [GenericFailure].
/// ✅ Used for native platform channel errors.
//
Failure _handlePlatform(PlatformException error) => GenericFailure(
  plugin: ErrorPlugins.useCase,
  code: error.code,
  message: error.message ?? 'Platform error occurred.',
  translationKey: FailureKeys.formatError,
);

////
////

/// 📦 [_handleMissingPlugin] — maps [MissingPluginException] to [GenericFailure].
/// ✅ Indicates an unregistered or unavailable platform plugin.
//
Failure _handleMissingPlugin(MissingPluginException error) => GenericFailure(
  plugin: ErrorPlugins.useCase,
  code: 'MISSING_PLUGIN',
  message: error.message ?? 'Plugin not initialized.',
  translationKey: FailureKeys.missingPlugin,
);

////
////

/// 🧾 [_handleFormat] — maps [FormatException] to [GenericFailure].
/// ✅ Used when malformed data is encountered (non-JSON).
//
Failure _handleFormat(FormatException error) => GenericFailure(
  plugin: ErrorPlugins.unknown,
  code: 'FORMAT_ERROR',
  message: 'Malformed data received.',
  translationKey: FailureKeys.formatError,
);

////
////

/// 🧬 [_handleJson] — maps [JsonUnsupportedObjectError] to [GenericFailure].
/// ✅ Indicates issues serializing non-supported JSON types.
//
Failure _handleJson(JsonUnsupportedObjectError error) => GenericFailure(
  plugin: ErrorPlugins.unknown,
  code: 'JSON_ERROR',
  message: 'Unsupported JSON: ${error.cause}',
  translationKey: FailureKeys.formatError,
);
