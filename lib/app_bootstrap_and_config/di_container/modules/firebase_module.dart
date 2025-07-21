import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, CollectionReference;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import '../core/di_module_interface.dart';
import '../di_container.dart';

final class FirebaseModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'FirebaseModule';

  ///
  @override
  List<Type> get dependencies => const [];

  ///
  @override
  Future<void> register() async {
    di.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    di.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    di.registerLazySingleton<CollectionReference<Map<String, dynamic>>>(
      () => FirebaseFirestore.instance.collection('users'),
    );
    // di.registerLazySingleton<CollectionReference<Map<String, dynamic>>>(
    //   () => FirebaseFirestore.instance.collection('users'),
    //   instanceName: 'usersCollection',
    // );
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
