import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:e_learning/features/home/presentation/view_model/home/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeBloc _homeBloc;
  final LoginStudentUsecase _loginStudentUsecase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeBloc homeBloc,
    required LoginStudentUsecase loginStudentUseCase,
  })  : _registerBloc = registerBloc,
        _homeBloc = homeBloc,
        _loginStudentUsecase = loginStudentUseCase,
        super(LoginState.initial()) {
    // Handle navigation to the Register screen
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _registerBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });

    // Handle login event
    on<LoginStudentEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final params = LoginStudentParams(
        email: event.email,
        password: event.password,
      );

      final result = await _loginStudentUsecase.call(params);

      result.fold(
        (failure) {
          // Handle failure (update the state with an error message)
          emit(state.copyWith(isLoading: false, isSuccess: false));
        },
        (student) {
          // On success, update state and navigate to the home screen
          emit(state.copyWith(isLoading: false, isSuccess: true));
        },
      );
    });
  }

  // Handle navigation to Home screen
  void navigateHomeScreenEvent(NavigateHomeScreenEvent event) {
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _homeBloc,
          child: event.destination,
        ),
      ),
    );
  }
}
