import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:path_provider/path_provider.dart';
import '../config/observer/app_bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> bootstrapApp() async {
  /// 🔐 Load environment variables from `.env` (✅ FIRST)
  await dotenv.load(fileName: ".env");
  print('✅ Env loaded: ${dotenv.env}');

  /// 🛠️ Set up a global BLoC observer
  Bloc.observer = AppBlocObserver();

  /// 🌐 Initialize Firebase with .env-based config
  await Firebase.initializeApp();

  /// 💾 Hydrated Storage (State Persistence)
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


/*
! can use next (then delete ❌ GoogleService-Info.plist google-services.json)
Future<void> safeFirebaseInit() async {
  if (Firebase.apps.isNotEmpty) {
    debugPrint('⚠️ Firebase already initialized');
    return;
  }

  // 🔁 Only for Web (або якщо прибрано plist/json)
  if (kIsWeb) {
    await Firebase.initializeApp(options: EnvFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(); // нативна ініціалізація
  }

  debugPrint('✅ Firebase initialized');
}

! then  will be used like this: 
await Firebase.initializeApp(options: EnvFirebaseOptions.currentPlatform);

 */