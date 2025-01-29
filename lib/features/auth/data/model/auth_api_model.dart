import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String fname;
  final String lname;
  final String? image;

  final String email;
  final String password;

  const AuthApiModel({
    this.userId,
    required this.fname,
    required this.lname,
    this.image,
    required this.email,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  factory AuthApiModel.fromEntity(AuthEntity entity) => AuthApiModel(
        userId: entity.userId,
        fname: entity.fname,
        lname: entity.lname,
        image: entity.image,
        email: entity.email,
        password: entity.password,
      );

  AuthEntity toEntity() => AuthEntity(
        userId: userId,
        fname: fname,
        lname: lname,
        image: image,
        email: email,
        password: password,
      );

  @override
  List<Object?> get props => [
        userId,
        fname,
        lname,
        image,
        email,
        password,
      ];
}
