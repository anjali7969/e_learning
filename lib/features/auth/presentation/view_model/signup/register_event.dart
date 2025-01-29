part of 'register_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToLoginScreenEvent extends SignupEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToLoginScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object?> get props => [context, destination];
}
