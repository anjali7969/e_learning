import 'package:e_learning/app/constants/hive_table_constant.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String fname;
  @HiveField(3)
  final String lname;
  @HiveField(4)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.email,
    required this.fname,
    required this.lname,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        email = '',
        fname = '',
        lname = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      email: entity.email,
      fname: entity.fname,
      lname: entity.lname,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      email: email,
      fname: fname,
      lname: lname,
      password: password,
    );
  }

  @override
  List<Object?> get props => [userId, email, fname, lname, password];
}
