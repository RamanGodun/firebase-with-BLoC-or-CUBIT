import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hydrated_bloc/hydrated_bloc.dart'
    show HydratedStorage, HydratedStorageDirectory, HydratedBloc;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

/// 💾 [ILocalStorageStack] — abstraction for local storage initialization.
/// ✅ Used to decouple local storage startup logic and enable mocking.

abstract interface class ILocalStorageStack {
  ///--------------------------------------
  //
  /// Initializes all local storage services (e.g., HydratedBloc, SharedPreferences)
  Future<void> initHydratedBloc();
  //
  // Optionally: init other storages (e.g., Isar, GetStorage, SharedPreferences)
  // Future<void> initGetStorage();
  //
}

////

////

/// 💾 [DefaultLocalStorageStack] — [ILocalStorageStack] implementation.

final class DefaultLocalStorageStack implements ILocalStorageStack {
  ///------------------------------------------------------------
  const DefaultLocalStorageStack();

  @override
  Future<void> initHydratedBloc() async {
    debugPrint('💾 Initializing HydratedBloc storage...');
    // Configures HydratedBloc persistent storage (Web or native)
    final storage = await HydratedStorage.build(
      storageDirectory:
          kIsWeb
              ? HydratedStorageDirectory.web
              : HydratedStorageDirectory(
                (await getApplicationDocumentsDirectory()).path,
              ),
    );
    HydratedBloc.storage = storage;
    debugPrint('💾 HydratedBloc storage initialized.');
  }

  //
}
