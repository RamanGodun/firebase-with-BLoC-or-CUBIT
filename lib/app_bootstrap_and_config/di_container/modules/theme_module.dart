import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/x_on_get_it.dart';
import '../../../core/base_modules/theme/theme_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container_init.dart';

/// 🎨 Registers theme Cubit for loader (and later, the main app).
//
final class ThemeModule implements DIModule {
  ///-------------------------------------
  //
  @override
  String get name => 'ThemeModule';

  ///
  @override
  List<Type> get dependencies => const [];

  ///
  @override
  Future<void> register() async {
    di.registerLazySingletonIfAbsent(() => AppThemeCubit());
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
