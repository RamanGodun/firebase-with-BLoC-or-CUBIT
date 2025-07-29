import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/x_on_get_it.dart';
import '../../../core/base_modules/overlays/overlay_dispatcher/_overlay_dispatcher.dart';
import '../../../core/base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container_initializaion.dart';
import 'theme_module.dart';

final class OverlaysModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'OverlaysModule';

  ///
  @override
  List<Type> get dependencies => const [ThemeModule];

  ///
  @override
  Future<void> register() async {
    di
      ..registerLazySingletonIfAbsent(() => OverlayStatusCubit())
      ..registerLazySingletonIfAbsent(
        () => OverlayDispatcher(
          onOverlayStateChanged: di<OverlayStatusCubit>().updateStatus,
        ),
      );
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
