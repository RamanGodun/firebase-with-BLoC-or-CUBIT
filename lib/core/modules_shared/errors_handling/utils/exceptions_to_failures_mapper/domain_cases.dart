part of '_exceptions_to_failures_mapper.dart';

/// 💾 [_handleFileSystem] — maps file system errors to [CacheFailure].
/// ✅ Handles local I/O issues (read/write/delete failures).

Failure _handleFileSystem(FileSystemException error) =>
    CacheFailure(message: error.message);

/// 🧠 [_handleArgument] — maps argument errors to [UseCaseFailure].
/// ✅ Used for invalid method inputs or domain logic violations.

Failure _handleArgument(ArgumentError error) =>
    UseCaseFailure(message: error.message ?? 'Invalid argument provided.');
