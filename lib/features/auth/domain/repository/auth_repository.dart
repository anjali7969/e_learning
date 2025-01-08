import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';

abstract class AuthRepository {
  Future<void> saveUser(AuthEntity user);
  AuthEntity? getUser();
  Future<void> logout();
}
