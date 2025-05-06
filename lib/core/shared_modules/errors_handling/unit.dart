/// 🧩 [Unit] — Represents void-like type in functional programming
/// ✅ Used for returning `Either<Failure, Unit>` when no value needed
//-------------------------------------------------------------------------
final class Unit {
  const Unit._();
}

/// 🌐 Singleton instance of [Unit]
const unit = Unit._();
