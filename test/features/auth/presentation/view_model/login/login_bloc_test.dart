import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:e_learning/features/auth/presentation/view/login_view.dart';
import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockLoginUsecase extends Mock implements LoginStudentUsecase {}

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterBloc {}

void main() {
  late LoginBloc loginBloc;
  late MockLoginUsecase loginUsecase;
  late RegisterBloc registerBloc;

  setUp(() {
    loginUsecase = MockLoginUsecase();
    registerBloc = MockRegisterBloc();
    loginBloc = LoginBloc(
      registerBloc: registerBloc,
      loginStudentUseCase: loginUsecase,
    );

    registerFallbackValue(const LoginStudentParams(email: '', password: ''));
  });

  group('LoginBloc Tests', () {
    const validEmail = 'test@gmail.com';
    const validPassword = 'password123';
    const loginParams =
        LoginStudentParams(email: validEmail, password: validPassword);

    blocTest<LoginBloc, LoginState>(
      'emits [isLoading=true, isSuccess=true] when login succeeds',
      build: () {
        when(() => loginUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
          const LoginStudentEvent(email: validEmail, password: validPassword)),
      expect: () => [
        LoginState.initial().copyWith(isLoading: true),
        LoginState.initial().copyWith(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => loginUsecase.call(loginParams)).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [isLoading=true, isSuccess=false] when login fails',
      build: () {
        when(() => loginUsecase.call(any())).thenAnswer((_) async =>
            const Left(ApiFailure(message: 'Invalid credentials')));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
          const LoginStudentEvent(email: validEmail, password: validPassword)),
      expect: () => [
        LoginState.initial().copyWith(isLoading: true),
        LoginState.initial().copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => loginUsecase.call(loginParams)).called(1);
      },
    );
  });

  tearDown(() {
    reset(loginUsecase);
    reset(registerBloc);
  });

  testWidgets('Valid Email and Password Input', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: const LoginView(),
        ),
      ),
    );

    final emailField = find.byKey(const Key('email'));
    final passwordField = find.byKey(const Key('password'));

    await tester.enterText(emailField, 'test@gmail.com');
    await tester.enterText(passwordField, 'password123');

    await tester.pump();

    expect(find.text('test@gmail.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });

  testWidgets('Invalid Email and Password Validation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: const LoginView(),
        ),
      ),
    );

    final emailField = find.byKey(const Key('email'));
    final passwordField = find.byKey(const Key('password'));
    final loginButton = find.byKey(const Key('loginButton'));

    await tester.ensureVisible(loginButton);

    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(passwordField, 'short');

    await tester.pump();

    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });
}
