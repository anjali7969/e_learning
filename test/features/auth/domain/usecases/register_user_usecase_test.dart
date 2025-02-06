import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth_repo.mock.dart';

void main() {
  late RegisterUseCase useCase;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RegisterUseCase(repository);
  });

  const registerParams = RegisterUserParams(
    userId: '1',
    email: 'test@gmail.com',
    name: 'Test User',
    phone: '1234567890',
    image: 'test_image.png',
    password: 'test1234',
  );

  final authEntity = AuthEntity(
    userId: registerParams.userId,
    email: registerParams.email,
    name: registerParams.name,
    password: registerParams.password,
    phone: registerParams.phone,
    image: registerParams.image,
  );

  test('should call registerUser in the repository with correct params',
      () async {
    // Arrange
    when(() => repository.registerUser(authEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(registerParams);

    // Assert
    expect(result, const Right(null));
    verify(() => repository.registerUser(authEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Left(Failure) when registration fails', () async {
    // Arrange
    const failure = ApiFailure(message: 'Registration failed');
    when(() => repository.registerUser(authEntity))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(registerParams);

    // Assert
    expect(result, const Left(failure));
    verify(() => repository.registerUser(authEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
