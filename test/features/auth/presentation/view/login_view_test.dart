// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
// import 'package:e_learning/features/auth/presentation/view/login_view.dart';
// import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mocktail/mocktail.dart';

// class MockLoginUsecase extends Mock implements LoginUseCase {}

// class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
//     implements LoginBloc {}

// class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
//     implements RegisterBloc {}

// void main() {
//   late LoginBloc loginBloc;
//   late MockLoginUsecase loginUsecase;
//   late RegisterBloc registerBloc;
//   late GetIt getIt;

//   setUp(() {
//     loginUsecase = MockLoginUsecase();
//     registerBloc = MockRegisterBloc();
//     loginBloc = MockLoginBloc();

//     getIt = GetIt.instance;
//     getIt.reset(); // Clears previous registrations

//     // Register the mock LoginBloc in GetIt for dependency injection
//     getIt.registerFactory<LoginBloc>(() => loginBloc);

//     // Ensure LoginBloc starts with the initial state
//     when(() => loginBloc.state).thenReturn(const LoginInitial());
//   });

//   testWidgets('Check email and password input fields exist', (tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<LoginBloc>.value(
//           value: loginBloc,
//           child: const LoginView(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     expect(find.byKey(const Key('email')), findsOneWidget);
//     expect(find.byKey(const Key('password')), findsOneWidget);
//   });

//   testWidgets('Check form validation errors when inputs are empty',
//       (tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<LoginBloc>.value(
//           value: loginBloc,
//           child: const LoginView(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byKey(const Key('email')), '');
//     await tester.enterText(find.byKey(const Key('password')), '');

//     await tester.tap(find.byKey(const Key('loginButton')));
//     await tester.pumpAndSettle();

//     expect(find.text('Please enter your email'), findsOneWidget);
//     expect(find.text('Please enter your password'), findsOneWidget);
//   });

//   testWidgets('Check successful login triggers navigation', (tester) async {
//     const email = 'user@gmail.com';
//     const password = 'password123';

//     when(() => loginUsecase(any()))
//         .thenAnswer((_) async => const Right(AuthResponse(
//               token: 'mock_token',
//               userId: 'mock_user_id',
//               name: 'mock_name',
//               email: 'mock_email',
//               role: 'mock_role',
//             )));

//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<LoginBloc>.value(
//           value: loginBloc,
//           child: const LoginView(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byKey(const Key('email')), email);
//     await tester.enterText(find.byKey(const Key('password')), password);

//     await tester.tap(find.byKey(const Key('loginButton')));
//     await tester.pumpAndSettle();

//     verify(() => loginUsecase(any())).called(1);
//   });

//   testWidgets('Invalid email/password should show Snackbar error',
//       (tester) async {
//     const email = 'invalid@gmail.com';
//     const password = 'wrongpassword';

//     when(() => loginUsecase(any())).thenAnswer(
//       (_) async => const Left(ApiFailure(message: 'Invalid credentials')),
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<LoginBloc>.value(
//           value: loginBloc,
//           child: const LoginView(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byKey(const Key('email')), email);
//     await tester.enterText(find.byKey(const Key('password')), password);

//     await tester.tap(find.byKey(const Key('loginButton')));
//     await tester.pumpAndSettle();

//     expect(find.text('Invalid credentials'), findsOneWidget);
//   });

//   testWidgets('Navigate to RegisterView when Sign Up button is clicked',
//       (tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<LoginBloc>.value(
//           value: loginBloc,
//           child: const LoginView(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     await tester.tap(find.text('Sign Up'));
//     await tester.pumpAndSettle();

//     verify(() => loginBloc.add(
//           NavigateRegisterScreenEvent(
//             context: any(named: 'context'),
//             destination: any(named: 'destination'),
//           ),
//         )).called(1);
//   });

//   tearDown(() {
//     getIt.reset(); // Reset GetIt to clean up mocks
//     reset(loginUsecase);
//     reset(registerBloc);
//   });
// }
