import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import '../../data/sources/remote/firebase_options.dart'
    show DefaultFirebaseOptions;
import '../config/observer/app_bloc_observer.dart';

Future<void> bootstrapApp() async {
  /// 🛠️ **Set up a global BLoC observer**
  Bloc.observer = AppBlocObserver();

  /// 🌐 Firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// 💾 **Initialize Hydrated Storage** (State Persistence)
  final storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(
              (await getApplicationDocumentsDirectory()).path,
            ),
  );
  HydratedBloc.storage = storage;
}
