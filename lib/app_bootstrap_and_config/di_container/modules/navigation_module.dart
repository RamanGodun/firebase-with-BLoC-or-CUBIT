import '../../../core/base_modules/navigation/core/router_cubit.dart';
import '../../../core/shared_domain_layer/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container.dart';
import 'auth_module.dart';

/// 🧭🚦 Registers the router Cubit (navigation logic).
//
final class NavigationModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'NavigationModule';

  ///
  @override
  List<Type> get dependencies => const [AuthModule];

  ///
  @override
  Future<void> register() async {
    di.registerLazySingleton<RouterCubit>(() => RouterCubit(di<AuthCubit>()));
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
