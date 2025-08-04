import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/_run_errors_handling.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/user_data_transfer_objects/user_dto_x.dart';
import '../../../../core/shared_data_layer/user_data_transfer_objects/user_dto_factories_x.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import '../../domain/repo_contracts.dart';
import '../data_source_contract.dart';

/// 🧩 [SignUpRepoImpl] — Repository for sign up feature.
/// ✅ Handles mapping of errors and between primitives/DTO
//
final class SignUpRepoImpl implements ISignUpRepo {
  ///---------------------------------------------
  //
  final IAuthRemoteDatabase _remote;
  const SignUpRepoImpl(this._remote);
  //

  @override
  ResultFuture<void> signup({
    required String name,
    required String email,
    required String password,
  }) =>
      () async {
        // 1️⃣ Create user (get UID)
        final uid = await _remote.signUp(email: email, password: password);

        // 2️⃣ Create DTO (or just user map)
        final dto = UserDTOFactories.newUser(id: uid, name: name, email: email);

        // 3️⃣ Save DTO as raw map (data source is agnostic)
        await _remote.saveUserData(uid, dto.toJsonMap());
      }.runWithErrorHandling();

  //
}
