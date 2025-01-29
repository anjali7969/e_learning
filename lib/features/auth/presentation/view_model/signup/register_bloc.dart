import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<SignupEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    on<NavigateToLoginScreenEvent>(_onNavigateToLoginScreenEvent);
  }

  void _onNavigateToLoginScreenEvent(
    NavigateToLoginScreenEvent event,
    Emitter<RegisterState> emit,
  ) {
    // Perform navigation using Navigator.push
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (context) => event.destination),
    );

    // Optionally, emit a new state if needed
    // emit(NavigateToLoginScreenState());
  }
}
