import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';


class AuthModel extends AuthEntity {
  AuthModel({required super.username, required super.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(username: json['username'], token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'token': token};
  }
}

