library;

/// 🧩 [Unit] — Represents void-like type in functional programming
/// ✅ Used for returning `Either<Failure, Unit>` when no value is needed
/// ✅ Useful for side-effect operations (e.g. logOut, delete, etc.)

final class Unit {
  const Unit._();
}

////

////

/// 🌐 Singleton instance of [Unit]
/// ✅ Use `unit` as the success value: `Right(unit)`

const unit = Unit._();

////

////

////

/// 📦 Example:
/// ```dart
/// Either<Failure, Unit> result = await logOut();
///
/// result.fold(
///   (failure) => showError(failure),
///   (_) => showSuccess(), // success, nothing returned
/// );
/// ```
