import 'package:e_learning/features/auth/presentation/view/register_view.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myasteer/features/auth/presentation/view/signup_view.dart'; // Update with the correct path
// import 'package:myasteer/features/auth/presentation/view_model/signup/signup_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._registerBloc) : super(null);

  final RegisterBloc _registerBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 10), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _registerBloc,
              child:
                  const RegisterView(), // Replace with your SignupView widget
            ),
          ),
        );
      }
    });
  }
}
