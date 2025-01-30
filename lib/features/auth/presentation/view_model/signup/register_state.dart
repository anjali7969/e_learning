part of 'register_bloc.dart';

class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  RegisterState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }
}
