import 'package:dio/dio.dart';
import 'package:e_learning/core/network/api_service.dart';
import 'package:e_learning/core/network/hive_service.dart';
import 'package:e_learning/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:e_learning/features/auth/data/repository/auth_local_repository.dart';
import 'package:e_learning/features/auth/data/repository/auth_remote_repository.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSplashDependencies();
  await _initSignupDependencies();
  await _initHomeDependencies();

  await _initLoginDependencies();
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

_initSignupDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init remote  data source
  getIt.registerLazySingleton(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // init remote repository
  getIt.registerLazySingleton(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // // register uploadimage usecase
  // getIt.registerLazySingleton<UploadImageUsecase>(
  //   () => UploadImageUsecase(
  //     getIt<AuthRemoteRepository>(),
  //   ),
  // );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  if (!getIt.isRegistered<LoginStudentUsecase>()) {
    getIt.registerLazySingleton<LoginStudentUsecase>(() =>
        LoginStudentUsecase(authRepository: getIt<AuthRemoteRepository>()));
  }
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginStudentUsecase: getIt<LoginStudentUsecase>(),
    ),
  );
}

_initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
