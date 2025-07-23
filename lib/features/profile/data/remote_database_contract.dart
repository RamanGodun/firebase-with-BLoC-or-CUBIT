/// 📡 [IProfileRemoteDatabase] — Contract for any user profile remote source.
/// ✅ Does not depend on specific database or DTO types.
//
abstract interface class IProfileRemoteDatabase {
  ///-------------------------------------------
  //
  /// Fetches user as a raw [Map] by UID, or null if not exists.
  Future<Map<String, dynamic>?> fetchUserMap(String uid);
  //
  /// Creates a user profile from map for given UID.
  Future<void> createUserMap(String uid, Map<String, dynamic> data);
  //
}
