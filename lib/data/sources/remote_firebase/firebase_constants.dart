import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 🌐 Global Firebase instances (used in UI/utils only — not in repositories)
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth fbAuth = FirebaseAuth.instance;

/// 🔗 Reference to the Firestore `users` collection
final usersCollection = firestore.collection('users');
