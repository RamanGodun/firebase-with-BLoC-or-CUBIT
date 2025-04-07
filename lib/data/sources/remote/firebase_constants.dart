import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// **Firebase Firestore Users Collection**
///
/// Reference to the `users` collection in Firestore.
/// Used for reading and writing user-related data.
final usersCollection = FirebaseFirestore.instance.collection('users');

/// **Firebase Authentication Instance**
///
/// Provides access to Firebase Authentication methods,
/// such as signing in, signing up, signing out, and user state management.
final fbAuth = FirebaseAuth.instance;
