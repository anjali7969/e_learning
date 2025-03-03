// import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
// import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:e_learning/features/home/presentation/view_model/home/home_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final LoginStudentUsecase _loginStudentUseCase;
//   final HomeBloc _homeBloc;
//   final RegisterBloc _registerBloc;

//   LoginBloc({
//     required RegisterBloc registerBloc,
//     required HomeBloc homeBloc,
//     required LoginStudentUsecase loginStudentUseCase,
//   })  : _loginStudentUseCase = loginStudentUseCase,
//         _homeBloc = homeBloc,
//         _registerBloc = registerBloc,
//         super(LoginState.initial()) {
//     // Handle login event
//     on<LoginStudentEvent>(_onLoginStudentEvent);

//     // Handle navigation to the Register screen
//     on<NavigateRegisterScreenEvent>(_handleNavigationToRegisterScreen);
//   }

//   /// **📌 Handle Login Event**
//   Future<void> _onLoginStudentEvent(
//       LoginStudentEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final params = LoginStudentParams(
//       email: event.email,
//       password: event.password,
//     );

//     final result = await _loginStudentUseCase.call(params);

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, isSuccess: false));

//         // ❌ Show error message
//         ScaffoldMessenger.of(event.context).showSnackBar(
//           SnackBar(
//             content: Text('Login failed: ${failure.message}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       },
//       (user) {
//         emit(state.copyWith(isLoading: false, isSuccess: true));

//         // ✅ Navigate to Home Screen on Success
//         Navigator.pushReplacement(
//           event.context,
//           MaterialPageRoute(
//             builder: (context) => BlocProvider.value(
//               value: _homeBloc,
//               child: event.destination,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// **📌 Handle Navigation to Register Screen**
//   void _handleNavigationToRegisterScreen(
//       NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
//     Navigator.push(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _registerBloc,
//           child: event.destination,
//         ),
//       ),
//     );
//   }
// }

import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginStudentUsecase loginUseCase;

  LoginBloc(this.loginUseCase) : super(const LoginInitial()) {
    // Handle navigation to the Register screen
    on<NavigateRegisterScreenEvent>((event, emit) {
      _handleNavigationToRegisterScreen(event);
    });

    // Handle login
    on<LoginStudentEvent>(
      (event, emit) async {
        emit(const LoginLoading());

        final result = await loginUseCase(LoginStudentParams(
          email: event.email,
          password: event.password,
        ));

        result.fold(
          (failure) => emit(LoginError(message: failure.message)),
          (success) => emit(LoginSuccess()),
        );
      },
    );
  }

  void _handleNavigationToRegisterScreen(NavigateRegisterScreenEvent event) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => event.destination,
      ),
    );
  }
}
