import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/x_on_get_it.dart';
import '../../../core/base_modules/form_fields/utils/form_validation_service.dart';
import '../core/di_module_interface.dart';
import '../di_container_init.dart';

///  🔐 Registers form validation service
//
final class FormFieldsModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'FormFieldsModule';

  ///
  @override
  List<Type> get dependencies => const [];

  ///
  @override
  Future<void> register() async {
    di.registerLazySingletonIfAbsent(() => const FormValidationService());
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
