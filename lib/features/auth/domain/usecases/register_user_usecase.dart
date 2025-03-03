import 'package:dartz/dartz.dart';
import 'package:e_learning/app/usecase/usecase.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

/// **📌 Register Parameters**
class RegisterUserParams extends Equatable {
  final String? userId;
  final String email;
  final String name;
  final String phone;
  final String? image;
  final String password;

  const RegisterUserParams({
    this.userId,
    required this.email,
    required this.name,
    required this.phone,
    this.image,
    required this.password,
  });

  /// **📌 Initial Constructor**
  const RegisterUserParams.initial({
    this.userId,
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [userId, email, name, phone, image, password];
}

/// **📌 Register UseCase**
class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) async {
    final authEntity = AuthEntity(
      userId: params.userId,
      email: params.email,
      name: params.name,
      password: params.password,
      phone: params.phone,
      image: params.image,
    );

    return repository.registerUser(authEntity);
  }
}
