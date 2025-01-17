import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String email;
  final String fname;
  final String lname;
  final String password;

  const AuthEntity({
    required this.email,
    this.userId,
    required this.fname,
    required this.lname,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, fname, lname, password, email];
}
