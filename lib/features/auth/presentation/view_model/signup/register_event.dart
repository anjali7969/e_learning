part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String email;
  final String name;
  final String phone;
  final String? image;
  final String password;

  const RegisterUser({
    required this.context,
    required this.email,
    required this.name,
    required this.phone,
    this.image,
    required this.password,
  });
}

// class NavigateLoginScreenEvent extends SignupEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateLoginScreenEvent({
//     required this.context,
//     required this.destination,
//   });
// }
