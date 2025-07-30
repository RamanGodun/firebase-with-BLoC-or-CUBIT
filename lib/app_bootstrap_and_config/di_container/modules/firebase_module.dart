import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, CollectionReference;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/x_on_get_it.dart';
import '../core/di_module_interface.dart';
import '../di_container_init.dart';

final class FirebaseModule implements DIModule {
  ///----------------------------------------
  //
  @override
  String get name => 'FirebaseModule';

  ///
  @override
  List<Type> get dependencies => const [];

  ///
  @override
  Future<void> register() async {
    di.registerLazySingletonIfAbsent<FirebaseAuth>(() => FirebaseAuth.instance);
    di.registerLazySingletonIfAbsent<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    di.registerLazySingletonIfAbsent<CollectionReference<Map<String, dynamic>>>(
      () => FirebaseFirestore.instance.collection('users'),
    );
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
