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
import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
import 'package:e_learning/core/network/api_service.dart';
import 'package:e_learning/core/network/hive_service.dart';
import 'package:e_learning/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:e_learning/features/auth/data/repository/auth_local_repository.dart';
import 'package:e_learning/features/auth/data/repository/auth_remote_repository.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:e_learning/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view_model/cubit/bottom_nav_cubit.dart';
import 'package:e_learning/features/cart/data/data_source/remote_datasource/cart_remote_datasource.dart';
import 'package:e_learning/features/cart/data/repository/cart_repository.dart';
import 'package:e_learning/features/cart/domain/repository/cart_repository.dart';
import 'package:e_learning/features/cart/domain/use_case/add_to_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/remove_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/update_cart_usecase.dart';
import 'package:e_learning/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:e_learning/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

/// **Initialize Dependencies**
Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  await _initSharedPreferences();
  await _initSignupDependencies();
  await _initLoginDependencies();
  await _initOnboardingDependencies();
  await _initBottomNavigationDependencies();
  await _initSplashDependencies();
  await _initCartDependencies(); // ✅ Initialize Cart Dependencies
}

/// **Initialize Shared Preferences**
Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

/// **Initialize API Service**
void _initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

/// **Initialize Hive Service**
void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

/// **Initialize Signup Dependencies**
Future<void> _initSignupDependencies() async {
  getIt.registerLazySingleton(() => AuthLocalDataSource(getIt<HiveService>()));

  getIt.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepository(getIt<AuthLocalDataSource>()));

  getIt.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>(), getIt<TokenSharedPrefs>()));

  getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

  getIt.registerLazySingleton<IAuthRepository>(
      () => getIt<AuthRemoteRepository>());

  getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthRemoteRepository>()));

  getIt.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(getIt<AuthRemoteRepository>()));

  getIt.registerFactory<RegisterBloc>(() => RegisterBloc(
        registerUseCase: getIt(),
        uploadImageUseCase: getIt(),
      ));
}

/// **Initialize Login Dependencies**
Future<void> _initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<LoginStudentUsecase>(() => LoginStudentUsecase(
        authRepository: getIt<IAuthRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ));

  getIt.registerFactory<LoginBloc>(() => LoginBloc(
        registerBloc: getIt<RegisterBloc>(),
        loginStudentUseCase: getIt<LoginStudentUsecase>(),
      ));
}

/// **Initialize Onboarding Dependencies**
Future<void> _initOnboardingDependencies() async {
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}

/// **Initialize Bottom Navigation Dependencies**
Future<void> _initBottomNavigationDependencies() async {
  getIt.registerFactory<BottomNavigationCubit>(() => BottomNavigationCubit());
}

/// **Initialize Splash Dependencies**
Future<void> _initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
      () => SplashCubit(getIt<OnboardingCubit>()));
}

/// **Initialize Cart Dependencies**
Future<void> _initCartDependencies() async {
  // ✅ Register Remote Data Source (Fixed incorrect parameter name)
  getIt.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSource(getIt<Dio>())); // ✅ Fixed `Dio: getIt<Dio>()`

  // ✅ Register Cart Repository (Fixed import)
  getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(getIt<CartRemoteDataSource>()));

  // ✅ Register Use Cases
  getIt.registerLazySingleton<GetCartUsecase>(
      () => GetCartUsecase(getIt<CartRepository>()));

  getIt.registerLazySingleton<AddToCartUsecase>(
      () => AddToCartUsecase(getIt<CartRepository>()));

  getIt.registerLazySingleton<UpdateCartItem>(
      () => UpdateCartItem(getIt<CartRepository>()));

  getIt.registerLazySingleton<RemoveCartItem>(
      () => RemoveCartItem(getIt<CartRepository>()));

  getIt.registerLazySingleton<ClearCart>(
      () => ClearCart(getIt<CartRepository>()));

  // ✅ Register Cart Cubit
  getIt.registerFactory<CartCubit>(() => CartCubit(
        getCartUsecase: getIt<GetCartUsecase>(),
        addToCartUsecase: getIt<AddToCartUsecase>(),
        updateCartItem: getIt<UpdateCartItem>(),
        removeCartItem: getIt<RemoveCartItem>(),
        clearCart: getIt<ClearCart>(),
      ));
}
