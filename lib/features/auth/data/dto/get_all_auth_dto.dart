import 'package:e_learning/features/auth/data/model/auth_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_auth_dto.g.dart';

@JsonSerializable()
class AuthDTO {
  final List<AuthApiModel> data;

  AuthDTO({required this.data});

  factory AuthDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDTOToJson(this);
}
