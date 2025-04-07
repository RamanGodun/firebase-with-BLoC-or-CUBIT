import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'app_user.freezed.dart';

/// **AppUser Model**
///
/// Represents a user entity in the application.
/// This model is immutable and uses the [freezed] package for enhanced
/// performance, deep equality checks, and improved maintainability.
@freezed
class AppUser with _$AppUser {
  /// **Factory Constructor**
  ///
  /// Creates an instance of [AppUser].
  /// Default values ensure that properties never contain `null` values.
  const factory AppUser({
    @Default('') String id,
    @Default('') String name,
    @Default('') String email,
  }) = _AppUser;

  /// **Factory Method: fromDoc**
  ///
  /// Creates an instance of [AppUser] from a Firestore document snapshot.
  ///
  /// - **[appUserDoc]** - Firestore document snapshot containing user data.
  /// - Returns an **immutable** [AppUser] object populated with Firestore data.
  factory AppUser.fromDoc(DocumentSnapshot appUserDoc) {
    final appUserData = appUserDoc.data() as Map<String, dynamic>;

    return AppUser(
      id: appUserDoc.id,
      name: appUserData['name'] ?? '',
      email: appUserData['email'] ?? '',
    );
  }
}
