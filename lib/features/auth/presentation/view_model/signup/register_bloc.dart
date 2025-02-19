import 'dart:io';

import 'package:e_learning/core/common/snackbar/my_snackbar.dart';
import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:e_learning/features/auth/presentation/view/login_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  // final LoginBloc _loginBloc;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc({
    // required LoginBloc loginBloc,
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUseCase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUseCase,

        // _loginBloc = loginBloc,

        super(RegisterState.initial()) {
    // on<NavigateLoginScreenEvent>((event, emit) {
    //   Navigator.push(
    //       event.context,
    //       MaterialPageRoute(
    //           builder: (context) => MultiBlocProvider(
    //               providers: [BlocProvider.value(value: _loginBloc)],
    //               child: event.destination)));
    // });
    on<RegisterUser>(_onRegisterEvent);
    on<LoadImage>(_onLoadImage);
  }

  void _onLoadImage(LoadImage event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
        name: event.name,
        email: event.email,
        phone: event.phone,
        image: state.imageName,
        password: event.password));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration successful");

        // ✅ Navigate to LoginView after successful registration
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      },
    );
  }
}
