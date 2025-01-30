import 'dart:io';

import 'package:e_learning/core/network/hive_service.dart';
import 'package:e_learning/features/auth/data/data_source/auth_data_source.dart';
import 'package:e_learning/features/auth/data/model/auth_hive_model.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
      userId: "1",
      name: "",
      phone: "",
      email: "",
      image: null,
      password: "",
    ));
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final user = await _hiveService.login(email, password);
      return Future.value("Login successful");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
}
