import '../../../core/base_modules/theme/theme_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container.dart';

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
    di.registerLazySingleton(() => AppThemeCubit());
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
