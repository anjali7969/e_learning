import 'package:dio/dio.dart';
import 'package:e_learning/app/constants/api_endpoints.dart';
import 'package:e_learning/core/network/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      // Sending the login request
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      // Log the full response to understand the structure
      print("API Response: ${response.data}");

      // Check if the response status code is 200 and the success flag is true
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Successfully logged in, return the full response data (including the token)
        return response
            .data; // This returns the entire response, including the token
      } else {
        // Log the failure response
        print("Login failed: ${response.data['message']}");
      }
    } catch (e) {
      // Log error during API call
      print("Error during login: $e");
      rethrow; // Propagate error for further handling
    }

    // Return null if login fails or an error occurs
    return null;
  }
}
