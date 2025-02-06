import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth_repo.mock.dart';

class MockFile extends Mock implements File {}

void main() {
  late UploadImageUsecase useCase;
  late MockAuthRepository repository;
  late MockFile mockFile;

  setUp(() {
    repository = MockAuthRepository();
    mockFile = MockFile();
    useCase = UploadImageUsecase(repository);
  });

  test('should call uploadProfilePicture in the repository with correct params',
      () async {
    // Arrange
    const String imageUrl = 'https://example.com/profile.png';
    when(() => repository.uploadprofilePicture(mockFile))
        .thenAnswer((_) async => const Right(imageUrl));

    // Act
    final result = await useCase(UploadImageParams(file: mockFile));

    // Assert
    expect(result, const Right(imageUrl));
    verify(() => repository.uploadprofilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Left(Failure) when image upload fails', () async {
    // Arrange
    const failure = ApiFailure(message: 'Image upload failed');
    when(() => repository.uploadprofilePicture(mockFile))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(UploadImageParams(file: mockFile));

    // Assert
    expect(result, const Left(failure));
    verify(() => repository.uploadprofilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
