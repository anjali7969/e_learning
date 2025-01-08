// auth/data/repositories/auth_repository_impl.dart
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_local_data_source.dart';
import '../model/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveUser(AuthModel user) async {
    await localDataSource.saveUserData(user.toJson());
  }

  @override
  AuthModel? getUser() {
    final data = localDataSource.getUserData();
    if (data != null) {
      return AuthModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUserData();
  }
}
