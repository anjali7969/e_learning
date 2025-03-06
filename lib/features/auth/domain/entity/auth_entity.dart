import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String email;
  final String name;
  final String phone;
  final String password;
  final String? image;

  const AuthEntity({
    this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    this.image,
  });

  const AuthEntity.empty()
      : name = "_empty.name",
        userId = '_empty.userId',
        image = '_empty.image',
        email = '_empty.email',
        password = "_empty.password",
        phone = '_empty.phone';

  @override
  List<Object?> get props => [
        userId,
        email,
        name,
        phone,
        password,
        image,
      ];
}
