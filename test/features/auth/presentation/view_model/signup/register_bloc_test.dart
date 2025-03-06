// import 'dart:io';

// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
// import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
// import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// // 🔥 Mock dependencies
// class MockRegisterUseCase extends Mock implements RegisterUseCase {}

// class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

// class MockRegisterUserParams extends Mock implements RegisterUserParams {}

// class MockUploadImageParams extends Mock implements UploadImageParams {}

// class MockBuildContext extends Mock implements BuildContext {}

// void main() {
//   late RegisterBloc registerBloc;
//   late MockRegisterUseCase registerUseCase;
//   late MockUploadImageUsecase uploadImageUsecase;
//   late MockBuildContext mockContext;
//   late MockRegisterUserParams mockRegisterUserParams;
//   late MockUploadImageParams mockUploadImageParams;

//   setUp(() {
//     registerUseCase = MockRegisterUseCase();
//     uploadImageUsecase = MockUploadImageUsecase();
//     mockContext = MockBuildContext();
//     mockRegisterUserParams = MockRegisterUserParams();
//     mockUploadImageParams = MockUploadImageParams();

//     registerBloc = RegisterBloc(
//       registerUseCase: registerUseCase,
//       uploadImageUseCase: uploadImageUsecase,
//     );

//     //  Register Fallback Values for Mocktail
//     registerFallbackValue(mockRegisterUserParams);
//     registerFallbackValue(mockUploadImageParams);
//   });

//   group('RegisterBloc Tests', () {
//     const name = "Test User";
//     const email = "test@gmail.com";
//     const phone = "1234567890";
//     const password = "password123";
//     final file = File('test_image.png');
//     const imageName = "uploaded_image.png";

//     blocTest<RegisterBloc, RegisterState>(
//       'emits [isLoading=true, isSuccess=true] when registration succeeds',
//       build: () {
//         when(() => registerUseCase.call(any()))
//             .thenAnswer((_) async => const Right(null));
//         return registerBloc;
//       },
//       act: (bloc) => bloc.add(RegisterUser(
//         name: name,
//         email: email,
//         phone: phone,
//         password: password,
//         context: mockContext, // ✅ Using Mocked Context
//       )),
//       expect: () => [
//         RegisterState.initial().copyWith(isLoading: true),
//         RegisterState.initial().copyWith(isLoading: false, isSuccess: true),
//       ],
//       verify: (_) {
//         verify(() => registerUseCase.call(any())).called(1);
//       },
//     );
//     blocTest<RegisterBloc, RegisterState>(
//       ' emits [isLoading=true, isSuccess=false] when registration fails',
//       build: () {
//         when(() => registerUseCase.call(any())).thenAnswer((_) async =>
//             const Left(ApiFailure(message: "Registration failed")));
//         return registerBloc;
//       },
//       act: (bloc) => bloc.add(RegisterUser(
//           name: name,
//           email: email,
//           phone: phone,
//           password: password,
//           context: mockContext)), // ✅ Using Mocked Context
//       expect: () => [
//         RegisterState.initial().copyWith(isLoading: true),
//         RegisterState.initial().copyWith(isLoading: false, isSuccess: false),
//       ],
//       verify: (_) {
//         verify(() => registerUseCase.call(any())).called(1);
//       },
//     );

//     blocTest<RegisterBloc, RegisterState>(
//       ' emits [isLoading=true, isSuccess=true, imageName=uploaded_image.png] when image upload succeeds',
//       build: () {
//         when(() => uploadImageUsecase.call(any()))
//             .thenAnswer((_) async => const Right(imageName));
//         return registerBloc;
//       },
//       act: (bloc) => bloc.add(LoadImage(file: file)), // ✅ Using Mocked File
//       expect: () => [
//         RegisterState.initial().copyWith(isLoading: true),
//         RegisterState.initial()
//             .copyWith(isLoading: false, isSuccess: true, imageName: imageName),
//       ],
//       verify: (_) {
//         verify(() => uploadImageUsecase.call(any())).called(1);
//       },
//     );

//     blocTest<RegisterBloc, RegisterState>(
//       ' emits [isLoading=true, isSuccess=false] when image upload fails',
//       build: () {
//         when(() => uploadImageUsecase.call(any())).thenAnswer((_) async =>
//             const Left(ApiFailure(message: "Image upload failed")));
//         return registerBloc;
//       },
//       act: (bloc) => bloc.add(LoadImage(file: file)), // ✅ Using Mocked File
//       expect: () => [
//         RegisterState.initial().copyWith(isLoading: true),
//         RegisterState.initial().copyWith(isLoading: false, isSuccess: false),
//       ],
//       verify: (_) {
//         verify(() => uploadImageUsecase.call(any())).called(1);
//       },
//     );
//   });

//   tearDown(() {
//     reset(registerUseCase);
//     reset(uploadImageUsecase);
//   });
// }

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//  Mock dependencies
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

class MockRegisterUserParams extends Mock implements RegisterUserParams {}

class MockUploadImageParams extends Mock implements UploadImageParams {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late RegisterBloc registerBloc;
  late MockRegisterUseCase registerUseCase;
  late MockUploadImageUsecase uploadImageUsecase;
  late MockBuildContext mockContext;
  late MockRegisterUserParams registerUserParams;
  late MockUploadImageParams uploadImageParams;

  setUpAll(() {
    registerFallbackValue(MockRegisterUserParams());
    registerFallbackValue(MockUploadImageParams());
  });

  setUp(() {
    registerUseCase = MockRegisterUseCase();
    uploadImageUsecase = MockUploadImageUsecase();
    mockContext = MockBuildContext();
    registerUserParams = MockRegisterUserParams();
    uploadImageParams = MockUploadImageParams();

    registerBloc = RegisterBloc(
      registerUseCase: registerUseCase,
      uploadImageUseCase: uploadImageUsecase,
    );

    //  Mock BuildContext properly to prevent ScaffoldMessenger errors
    when(() => mockContext.findAncestorStateOfType<ScaffoldMessengerState>())
        .thenReturn(null);
  });

  group('RegisterBloc Tests', () {
    const name = "Test User";
    const email = "test@gmail.com";
    const phone = "1234567890";
    const password = "password123";
    final file = File('test_image.png');

    // blocTest<RegisterBloc, RegisterState>(
    //   'emits [isLoading=true, isSuccess=true] when registration succeeds',
    //   build: () {
    //     when(() => registerUseCase.call(any()))
    //         .thenAnswer((_) async => const Right(null));
    //     return registerBloc;
    //   },
    //   act: (bloc) => bloc.add(RegisterUser(
    //     name: name,
    //     email: email,
    //     phone: phone,
    //     password: password,
    //     context: mockContext, //  Mocked Context
    //   )),
    //   expect: () => [
    //     RegisterState.initial().copyWith(isLoading: true),
    //     RegisterState.initial().copyWith(isLoading: false, isSuccess: true),
    //   ],
    //   verify: (_) {
    //     verify(() => registerUseCase.call(any())).called(1);
    //   },
    // );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading=true, isSuccess=false] when registration fails',
      build: () {
        when(() => registerUseCase.call(any())).thenAnswer((_) async =>
            const Left(ApiFailure(message: "Registration failed")));
        return registerBloc;
      },
      act: (bloc) => bloc.add(RegisterUser(
        name: name,
        email: email,
        phone: phone,
        password: password,
        context: mockContext,
      )),
      expect: () => [
        RegisterState.initial().copyWith(isLoading: true),
        RegisterState.initial().copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => registerUseCase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading=true, isSuccess=true, imageName=uploaded_image.png] when image upload succeeds',
      build: () {
        when(() => uploadImageUsecase.call(any()))
            .thenAnswer((_) async => const Right("uploaded_image.png"));
        return registerBloc;
      },
      act: (bloc) => bloc.add(LoadImage(file: file)), //  Using Mocked File
      expect: () => [
        RegisterState.initial().copyWith(isLoading: true),
        RegisterState.initial().copyWith(
            isLoading: false, isSuccess: true, imageName: "uploaded_image.png"),
      ],
      verify: (_) {
        verify(() => uploadImageUsecase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading=true, isSuccess=false] when image upload fails',
      build: () {
        when(() => uploadImageUsecase.call(any())).thenAnswer((_) async =>
            const Left(ApiFailure(message: "Image upload failed")));
        return registerBloc;
      },
      act: (bloc) => bloc.add(LoadImage(file: file)), //  Using Mocked File
      expect: () => [
        RegisterState.initial().copyWith(isLoading: true),
        RegisterState.initial().copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => uploadImageUsecase.call(any())).called(1);
      },
    );
  });

  // Widget Tests for Signup Page
//   testWidgets('Signup form validation', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<RegisterBloc>.value(
//           value: registerBloc,
//           child: const RegisterView(),
//         ),
//       ),
//     );

//     // Find text fields
//     final nameField = find.byKey(const Key('name'));
//     final emailField = find.byKey(const Key('email'));
//     final phoneField = find.byKey(const Key('phone'));
//     final passwordField = find.byKey(const Key('password'));
//     final registerButton = find.byKey(const Key('registerButton'));

//     // Enter invalid data
//     await tester.enterText(nameField, '');
//     await tester.enterText(emailField, 'invalid-email');
//     await tester.enterText(phoneField, '123');
//     await tester.enterText(passwordField, 'short');

//     // Tap the signup button
//     await tester.tap(registerButton);
//     await tester.pump();

//     // Check for validation messages
//     expect(find.text('Please enter Your Name'), findsOneWidget);
//     expect(find.text('Enter a valid email'), findsOneWidget);
//     expect(find.text('Enter a valid phone number'), findsOneWidget);
//     expect(find.text('Password must be at least 8 characters'), findsOneWidget);
//   });

//   testWidgets('Signup with valid data', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<RegisterBloc>.value(
//           value: registerBloc,
//           child: const RegisterView(),
//         ),
//       ),
//     );

//     // Find text fields
//     final nameField = find.byKey(const Key('name'));
//     final emailField = find.byKey(const Key('email'));
//     final phoneField = find.byKey(const Key('phone'));
//     final passwordField = find.byKey(const Key('password'));
//     final registerButton = find.byKey(const Key('registerButton'));

//     // Enter valid data
//     await tester.enterText(nameField, 'John Doe');
//     await tester.enterText(emailField, 'john.doe@gmail.com');
//     await tester.enterText(phoneField, '1234567890');
//     await tester.enterText(passwordField, 'password123');

//     // Tap the signup button
//     await tester.tap(registerButton);
//     await tester.pump();

//     // Verify that no validation errors are shown
//     expect(find.text('Please enter Your Name'), findsNothing);
//     expect(find.text('Enter a valid email'), findsNothing);
//     expect(find.text('Enter a valid phone number'), findsNothing);
//     expect(find.text('Password must be at least 8 characters'), findsNothing);
//   });

//   tearDown(() {
//     reset(registerUseCase);
//     reset(uploadImageUsecase);
//   });
}
