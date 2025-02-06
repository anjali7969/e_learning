import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_learning/app/usecase/usecase.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({
    required this.file,
  });
}

class UploadImageUsecase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IAuthRepository _repository;

  UploadImageUsecase(this._repository);
  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadprofilePicture(params.file);
  }
}
