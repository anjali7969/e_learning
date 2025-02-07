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
// import 'package:mocktail/mocktail.dart';

// class MockLoginUsecase extends Mock implements LoginStudentUsecase {}

// class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
//     implements RegisterBloc {}

// void main() {
//   late LoginBloc loginBloc;
//   late MockLoginUsecase loginUsecase;
//   late RegisterBloc registerBloc;

//   setUp(() {
//     loginUsecase = MockLoginUsecase();
//     registerBloc = MockRegisterBloc();
//     loginBloc = LoginBloc(
//       registerBloc: registerBloc,
//       loginStudentUseCase: loginUsecase,
//     );

//     registerFallbackValue(const LoginStudentParams(email: '', password: ''));
//   });

//   test('initial state should be LoginState.initial()', () {
//     expect(loginBloc.state, equals(LoginState.initial()));
//     expect(loginBloc.state.isLoading, false);
//     expect(loginBloc.state.isSuccess, false);
//   });

//   testWidgets('Check for the email and password input fields in LoginView',
//       (tester) async {
//     await tester.pumpWidget(MaterialApp(
//       home: BlocProvider(
//         create: (context) => loginBloc,
//         child: LoginView(),
//       ),
//     ));

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextFormField).at(0), 'user@gmail.com');
//     await tester.enterText(find.byType(TextFormField).at(1), 'password123');

//     expect(find.text('user@gmail.com'), findsOneWidget);
//     expect(find.text('password123'), findsOneWidget);
//   });

//   testWidgets('Check for validator errors when inputs are empty',
//       (tester) async {
//     await tester.pumpWidget(MaterialApp(
//       home: BlocProvider(
//         create: (context) => loginBloc,
//         child: LoginView(),
//       ),
//     ));

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextFormField).at(0), '');
//     await tester.enterText(find.byType(TextFormField).at(1), '');

//     await tester.tap(find.byType(ElevatedButton).first);

//     await tester.pumpAndSettle();

//     expect(find.text('Please enter your email'), findsOneWidget);
//     expect(find.text('Please enter your password'), findsOneWidget);
//   });

//   testWidgets('Check successful login with correct email and password',
//       (tester) async {
//     const email = 'user@gmail.com';
//     const password = 'password123';
//     const token = 'mock_token';

//     when(() => loginUsecase(any())).thenAnswer((_) async => const Right(token));

//     await tester.pumpWidget(MaterialApp(
//       home: BlocProvider(
//         create: (context) => loginBloc,
//         child: LoginView(),
//       ),
//     ));

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextFormField).at(0), email);
//     await tester.enterText(find.byType(TextFormField).at(1), password);

//     await tester.tap(find.byType(ElevatedButton).first);
//     await tester.pumpAndSettle();

//     expect(loginBloc.state.isSuccess, false);
//   });

//   testWidgets('Invalid email/password should show snackbar error',
//       (tester) async {
//     const email = 'invalid@gmail.com';
//     const password = 'wrongpassword';

//     when(() => loginUsecase(any())).thenAnswer(
//       (_) async => const Left(ApiFailure(message: 'Invalid credentials')),
//     );

//     await tester.pumpWidget(MaterialApp(
//       home: BlocProvider(
//         create: (context) => loginBloc,
//         child: LoginView(),
//       ),
//     ));

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextFormField).at(0), email);
//     await tester.enterText(find.byType(TextFormField).at(1), password);

//     await tester.tap(find.byType(ElevatedButton).first);
//     await tester.pumpAndSettle();

//     expect(find.text('Invalid credentials'), findsOneWidget);
//   });

//   testWidgets('Navigate to RegisterView when SignUp button is clicked',
//       (tester) async {
//     await tester.pumpWidget(MaterialApp(
//       home: BlocProvider(
//         create: (context) => loginBloc,
//         child: LoginView(),
//       ),
//     ));

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
//     reset(loginUsecase);
//     reset(registerBloc);
//   });
// }
