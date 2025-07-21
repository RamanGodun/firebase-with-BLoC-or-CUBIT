library;

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

/// 🗃️ [DataSourceConstants] — Centralized Firestore collection names
/// ✅ Use to avoid hardcoded strings throughout data layer
//
abstract final class DataSourceConstants {
  //-------------------------------------

  @pragma('vm:prefer-inline')
  const DataSourceConstants._();
  //

  /// 🧩 [usersCollection] — Firestore reference to the `users` collection
  /// 📦 Used for fetching and storing user-specific data
  // static const String usersCollection = 'users';
  static final usersCollection = FirebaseFirestore.instance.collection('users');

  /// 🧩 [fbAuth] — Firebase Authentication instance
  /// 📦 Provides access to Firebase user-related auth methods
  //
  static final fbAuth = FirebaseAuth.instance;

  // 🧩 Extend with more collections as needed (e.g., 'tasks', 'chats', etc.)
}
