library;

/// 🗃️ [DataSourceConstants] — Centralized Firestore collection names
/// ✅ Use to avoid hardcoded strings throughout data layer
//----------------------------------------------------------------

final class DataSourceConstants {
  @pragma('vm:prefer-inline')
  const DataSourceConstants._();

  /// 👥 Firestore collection for user profiles
  static const String usersCollection = 'users';

  // 🧩 Extend with more collections as needed (e.g., 'tasks', 'chats', etc.)
}
