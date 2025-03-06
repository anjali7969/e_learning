import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';

abstract interface class IAuthDataSource {
  Future<AuthResponse> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();
}
