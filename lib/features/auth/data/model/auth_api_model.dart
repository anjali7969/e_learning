import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? studentId;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String password;

  const AuthApiModel({
    this.studentId,
    required this.email,
    required this.name,
    required this.phone,
    this.image,
    required this.password,
  });

  /// JSON Serialization
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  /// Convert from Entity to API Model
  factory AuthApiModel.fromEntity(AuthEntity entity) => AuthApiModel(
        studentId: entity.userId,
        email: entity.email,
        name: entity.name,
        phone: entity.phone,
        image: entity.image,
        password: entity.password,
      );

  /// Convert API Model to Entity
  AuthEntity toEntity() => AuthEntity(
        userId: studentId,
        email: email,
        name: name,
        phone: phone,
        image: image,
        password: password,
      );

  @override
  List<Object?> get props => [studentId, email, name, phone, image, password];
}
