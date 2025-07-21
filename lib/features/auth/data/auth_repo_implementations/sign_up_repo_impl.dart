import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/failure_handling.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/shared_data_transfer_objects/user_dto_x.dart';

import '../../../../core/shared_data_layer/shared_data_transfer_objects/user_dto_factories_x.dart';
import '../../../../core/utils_shared/typedef.dart';
import '../../domain/i_repo.dart';
import '../data_source_contract.dart';

/// 🧩 [SignUpRepoImpl] — Repository for sign up feature.
/// ✅ Handles mapping of errors and between primitives/DTO
//
final class SignUpRepoImpl implements ISignUpRepo {
  ///---------------------------------------------
  //
  final IAuthRemoteDataSource _remote;
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
}
