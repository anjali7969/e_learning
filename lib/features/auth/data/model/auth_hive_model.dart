import 'package:e_learning/app/constants/hive_table_constant.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String password;

  AuthHiveModel({
    String? studentId,
    required this.email,
    required this.name,
    required this.phone,
    this.image,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        email = '',
        name = '',
        phone = '',
        image = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.userId,
      email: entity.email,
      name: entity.name,
      phone: entity.phone,
      image: entity.image,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: studentId,
      email: email,
      name: name,
      phone: phone,
      image: image,
      password: password,
    );
  }

  @override
  List<Object?> get props => [
        studentId,
        email,
        name,
        phone,
        image,
        password,
      ];
}
