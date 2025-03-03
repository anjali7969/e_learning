// import 'package:dio/dio.dart';
// import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
// import 'package:e_learning/core/network/api_service.dart';
// import 'package:e_learning/core/network/hive_service.dart';
// import 'package:e_learning/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
// import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
// import 'package:e_learning/features/auth/data/repository/auth_local_repository.dart';
// import 'package:e_learning/features/auth/data/repository/auth_remote_repository.dart';
// import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
// import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
// import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
// import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:e_learning/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
// import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final getIt = GetIt.instance;

// Future<void> initDependencies() async {
//   await _initHiveService();
//   await _initApiService();
//   await _initSharedPreferences();

//   await _initSignupDependencies();
//   await _initLoginDependencies();
//   await _initSplashDependencies();
// }

// Future<void> _initSharedPreferences() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
// }

// _initApiService() {
//   //remote data souce
//   getIt.registerLazySingleton<Dio>(
//     () => ApiService(Dio()).dio,
//   );
// }

// _initHiveService() {
//   getIt.registerLazySingleton<HiveService>(() => HiveService());
// }

// _initSignupDependencies() async {
//   getIt.registerLazySingleton(
//     () => AuthLocalDataSource(getIt<HiveService>()),
//   );

//   // init local repository
//   // getIt.registerLazySingleton(
//   //   () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
//   // );

//   //Remote data source
//   getIt.registerFactory<AuthRemoteDataSource>(
//       () => AuthRemoteDataSource(getIt<Dio>()));

//   //local Remotre
//   getIt.registerLazySingleton<AuthLocalRepository>(
//       () => AuthLocalRepository(getIt<AuthLocalDataSource>()));

//   //Repo Remotre
//   getIt.registerLazySingleton<AuthRemoteRepository>(
//       () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

//   // register use usecasec
//   getIt.registerLazySingleton<RegisterUseCase>(
//     () => RegisterUseCase(
//       getIt<AuthRemoteRepository>(),
//     ),
//   );

//   // Upload image use case
//   getIt.registerLazySingleton<UploadImageUsecase>(
//     () => UploadImageUsecase(
//       getIt<AuthRemoteRepository>(),
//     ),
//   );

//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(
//       registerUseCase: getIt(),
//       uploadImageUseCase: getIt(),
//     ),
//   );

//   // getIt.registerFactory<SignupBloc>(
//   //   () => SignupBloc(
//   //     loginBloc: getIt<LoginBloc>(),
//   //     registerUseCase: getIt(),
//   //   ),
//   // );
// }

// _initLoginDependencies() async {
//   getIt.registerLazySingleton<TokenSharedPrefs>(
//     () => TokenSharedPrefs(getIt<SharedPreferences>()),
//   );

//   getIt.registerLazySingleton<LoginStudentUsecase>(
//     () => LoginStudentUsecase(
//       authRepository: getIt<AuthRemoteRepository>(),
//       tokenSharedPrefs: getIt<TokenSharedPrefs>(),
//     ),
//   );

//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       registerBloc: getIt<RegisterBloc>(),
//       loginStudentUseCase: getIt<LoginStudentUsecase>(),
//     ),
//   );
// }

// _initSplashDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<OnboardingCubit>()),
//   );
// }

import 'package:dio/dio.dart';
import 'package:e_learning/app/shared_prefs/onboarding_shared_prefs.dart';
import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
import 'package:e_learning/app/shared_prefs/user_shared_prefs.dart';
import 'package:e_learning/core/network/api_service.dart';
import 'package:e_learning/core/network/hive_service.dart';
import 'package:e_learning/core/network/internet_checker.dart';
import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:e_learning/features/auth/data/repository/auth_remote_repository.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view_model/cubit/bottom_nav_cubit.dart';
import 'package:e_learning/features/home/presentation/view_model/home/home_bloc.dart';
import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

/// **🚀 Initialize Dependencies**
Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initAuthDependencies(); // ✅ Combined Auth Dependencies
  await _initSplashDependencies();
  await _initBottomNavigationDependencies();
  await _initHomeDependencies();
}

/// **🔹 Initialize Hive Service**
Future<void> _initHiveService() async {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

/// **🔹 Initialize Shared Preferences**
/// **🔹 Initialize Shared Preferences**
Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ✅ Register TokenSharedPrefs
  getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()));

  // ✅ Register OnboardingSharedPrefs
  getIt.registerLazySingleton<OnboardingSharedPrefs>(
      () => OnboardingSharedPrefs(getIt<SharedPreferences>()));

  // ✅ FIX: Register UserSharedPrefs (THIS WAS MISSING)
  getIt.registerLazySingleton<UserSharedPrefs>(
      () => UserSharedPrefs(getIt<SharedPreferences>()));
}

/// **🔹 Initialize API Service**
Future<void> _initApiService() async {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
  getIt.registerLazySingleton<InternetChecker>(
      () => InternetCheckerImpl(InternetConnection.createInstance()));
}

/// **🔹 Initialize Auth Dependencies** (Includes Login & Signup)
Future<void> _initAuthDependencies() async {
  // ✅ Register Remote Data Source (Fix for your error)
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>(), getIt()));

  // ✅ Register Repository
  getIt.registerLazySingleton<IAuthRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>(), getIt()));

  // ✅ Register UseCases
  getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<IAuthRepository>()));
  getIt.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(getIt<IAuthRepository>()));
  getIt.registerLazySingleton<LoginStudentUsecase>(
    () => LoginStudentUsecase(
      dio: getIt<Dio>(),
      authRepository: getIt<IAuthRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  // ✅ Register BLoCs
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUseCase: getIt<UploadImageUsecase>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      getIt<LoginStudentUsecase>(),
    ),
  );
}

/// **🔹 Initialize Splash Dependencies**
Future<void> _initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<TokenSharedPrefs>(), getIt<OnboardingSharedPrefs>(),
        getIt<UserSharedPrefs>()),
  );
}

/// **🔹 Initialize Bottom Navigation Dependencies**
Future<void> _initBottomNavigationDependencies() async {
  getIt.registerFactory<BottomNavigationCubit>(() => BottomNavigationCubit());
}

/// **🔹 Initialize Home Dependencies**
Future<void> _initHomeDependencies() async {
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
}
