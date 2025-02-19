import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_learning/app/constants/api_endpoints.dart';
import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
import 'package:e_learning/features/auth/data/data_source/auth_data_source.dart';
import 'package:e_learning/features/auth/data/model/auth_api_model.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenPrefs; // 🔹 Inject Token Storage

  AuthRemoteDataSource(this._dio, this._tokenPrefs);

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      var studentApiModel = AuthApiModel.fromEntity(user);
      var response = await _dio.post(
        ApiEndpoints.register,
        data: studentApiModel.toJson(),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error during registration: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // @override
  // Future<String> loginUser(String email, String password) async {
  //   try {
  //     var response = await _dio.post(
  //       ApiEndpoints.login,
  //       data: {'email': email, 'password': password},
  //     );

  //     if (response.statusCode == 200) {
  //       final str = response.data['token'];
  //       return str;
  //     } else {
  //       throw Exception('Failed to login: ${response.statusMessage}');
  //     }
  //   } on DioException catch (e) {
  //     throw Exception('Network error during login: ${e.message}');
  //   } catch (e) {
  //     throw Exception('Unexpected error: $e');
  //   }
  // }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];

        if (token == null || token.isEmpty) {
          throw Exception("❌ Received empty or invalid token!");
        }

        // ✅ Save token after login
        final result = await _tokenPrefs.saveToken(token);
        result.fold(
          (failure) => print("❌ Failed to save token: ${failure.message}"),
          (_) => print("✅ Token saved successfully!"),
        );

        return token;
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error during login: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() async {
    try {
      final tokenEither = await _tokenPrefs.getToken();

      if (tokenEither.isLeft()) {
        throw Exception("❌ Failed to retrieve token from SharedPreferences.");
      }

      final token = tokenEither.getOrElse(() => '');

      if (token.isEmpty) {
        throw Exception("❌ No authentication token found!");
      }

      var response = await _dio.get(
        ApiEndpoints.getCurrentUser,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return AuthApiModel.fromJson(response.data['user']).toEntity();
      } else {
        throw Exception('❌ Failed to fetch user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Network error while fetching user: $e');
    }
  }

  @override
  Future<String> uploadprofilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture':
            await MultipartFile.fromFile(file.path, filename: fileName),
      });

      var response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(
            'Failed to upload profile picture: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error during profile upload: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
