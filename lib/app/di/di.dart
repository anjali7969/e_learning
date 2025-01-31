// // import 'package:dio/dio.dart';
// // import 'package:e_learning/core/network/api_service.dart';
// // import 'package:e_learning/core/network/hive_service.dart';
// // import 'package:e_learning/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
// // import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
// // import 'package:e_learning/features/auth/data/repository/auth_local_repository.dart';
// // import 'package:e_learning/features/auth/data/repository/auth_remote_repository.dart';
// // import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
// // import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
// // import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
// // import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// // import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
// // import 'package:get_it/get_it.dart';

// // final getIt = GetIt.instance;

// // Future<void> initDependencies() async {
// //   await _initHiveService();
// //   await _initApiService();
// //   await _initSignupDependencies();
// //   await _initLoginDependencies();
// //   await _initSplashDependencies();
// // }

// // _initApiService() {
// //   //remote data souce
// //   getIt.registerLazySingleton<Dio>(
// //     () => ApiService(Dio()).dio,
// //   );
// // }

// // _initHiveService() {
// //   getIt.registerLazySingleton<HiveService>(() => HiveService());
// // }

// // _initLoginDependencies() async {
// //   if (!getIt.isRegistered<LoginStudentUsecase>()) {
// //     getIt.registerLazySingleton<LoginStudentUsecase>(() =>
// //         LoginStudentUsecase(authRepository: getIt<AuthRemoteRepository>()));
// //   }
// //   getIt.registerFactory<LoginBloc>(
// //     () => LoginBloc(
// //       registerBloc: getIt<RegisterBloc>(),
// //       // homeBloc: getIt<HomeBloc>(),
// //       loginStudentUseCase: getIt<LoginStudentUsecase>(),
// //     ),
// //   );
// // }

// // _initSignupDependencies() async {
// //   getIt.registerLazySingleton(
// //     () => AuthLocalDataSource(getIt<HiveService>()),
// //   );

// //   // init local repository
// //   getIt.registerLazySingleton(
// //     () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
// //   );

// //   // register use usecase
// //   getIt.registerLazySingleton<RegisterUseCase>(
// //     () => RegisterUseCase(
// //       getIt<AuthRemoteRepository>(),
// //     ),
// //   );

// //   //Upload image use case
// //   // getIt.registerLazySingleton<UploadImageUsecase>(
// //   //   () => UploadImageUsecase(
// //   //     getIt<AuthRemoteRepository>(),
// //   //   ),
// //   // );

// //   getIt.registerFactory<RegisterBloc>(
// //     () => RegisterBloc(
// //       registerUseCase: getIt(),
// //     ),
// //   );

// //   //Remote data source
// //   getIt.registerFactory<AuthRemoteDataSource>(
// //       () => AuthRemoteDataSource(getIt<Dio>()));

// //   //Repo Remotre
// //   getIt.registerLazySingleton<AuthRemoteRepository>(
// //       () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

// //   // getIt.registerFactory<SignupBloc>(
// //   //   () => SignupBloc(
// //   //     loginBloc: getIt<LoginBloc>(),
// //   //     registerUseCase: getIt(),
// //   //   ),
// //   // );

// //   //Remote data sourc
// // }

// // _initSplashDependencies() async {
// //   getIt.registerFactory<SplashCubit>(
// //     () => SplashCubit(getIt<LoginBloc>()),
// //   );
// // }

// import 'package:dio/dio.dart';
// import 'package:e_learning/core/network/api_service.dart';
// import 'package:e_learning/core/network/hive_service.dart';
// import 'package:e_learning/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
// import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
// import 'package:e_learning/features/auth/data/repository/auth_local_repository.dart';
// import 'package:e_learning/features/auth/data/repository/auth_remote_repository.dart';
// import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
// import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
// import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
// import 'package:get_it/get_it.dart';

// final getIt = GetIt.instance;

// /// **Initialize Dependencies**
// Future<void> initDependencies() async {
//   _initHiveService();
//   _initApiService();
//   await _initAuthDependencies();
//   await _initSplashDependencies();
// }

// /// **Initialize Hive (Local Storage)**
// void _initHiveService() {
//   getIt.registerLazySingleton<HiveService>(() => HiveService());
// }

// /// **Initialize API Service**
// void _initApiService() {
//   getIt.registerLazySingleton<Dio>(
//     () => ApiService(Dio()).dio,
//   );
// }

// /// **Initialize Authentication Dependencies**
// Future<void> _initAuthDependencies() async {
//   // **Local Data Source**
//   getIt.registerLazySingleton<AuthLocalDataSource>(
//     () => AuthLocalDataSource(getIt<HiveService>()),
//   );

//   // **Local Repository**
//   getIt.registerLazySingleton<AuthLocalRepository>(
//     () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
//   );

//   // **Remote Data Source**
//   getIt.registerFactory<AuthRemoteDataSource>(
//     () => AuthRemoteDataSource(getIt<Dio>()),
//   );

//   // **Remote Repository**
//   getIt.registerLazySingleton<AuthRemoteRepository>(
//     () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
//   );

//   // **Use Cases**
//   getIt.registerLazySingleton<RegisterUseCase>(
//     () => RegisterUseCase(getIt<AuthRemoteRepository>()),
//   );

//   getIt.registerLazySingleton<LoginStudentUsecase>(
//     () => LoginStudentUsecase(authRepository: getIt<AuthRemoteRepository>()),
//   );

//   // **Bloc Instances**
//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()),
//   );

//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       registerBloc: getIt<RegisterBloc>(),
//       loginStudentUseCase: getIt<LoginStudentUsecase>(),
//     ),
//   );
// }

// /// **Initialize Splash Dependencies**
// Future<void> _initSplashDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<LoginBloc>()),
//   );
// }

import 'package:dio/dio.dart';
import 'package:e_learning/core/network/api_service.dart';
import 'package:e_learning/core/network/hive_service.dart';
import 'package:e_learning/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:e_learning/features/auth/data/repository/auth_local_repository.dart';
import 'package:e_learning/features/auth/data/repository/auth_remote_repository.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSignupDependencies();
  await _initLoginDependencies();
  await _initSplashDependencies();
}

_initApiService() {
  //remote data souce
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initSignupDependencies() async {
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  // getIt.registerLazySingleton(
  //   () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  // );

  //Remote data source
  getIt.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));

  //local Remotre
  getIt.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepository(getIt<AuthLocalDataSource>()));

  //Repo Remotre
  getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // Upload image use case
  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUseCase: getIt(),
    ),
  );

  // getIt.registerFactory<SignupBloc>(
  //   () => SignupBloc(
  //     loginBloc: getIt<LoginBloc>(),
  //     registerUseCase: getIt(),
  //   ),
  // );
}

_initLoginDependencies() async {
  if (!getIt.isRegistered<LoginStudentUsecase>()) {
    getIt.registerLazySingleton<LoginStudentUsecase>(() =>
        LoginStudentUsecase(authRepository: getIt<AuthRemoteRepository>()));
  }

  // getIt.registerLazySingleton<LoginStudentUsecase>(
  //   () => LoginStudentUsecase(
  //     getIt<authRemoteRepository>(),
  //   ),
  // );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      loginStudentUseCase: getIt<LoginStudentUsecase>(),
    ),
  );
}

_initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<RegisterBloc>()),
  );
}
