// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TokenSharedPrefs {
//   final SharedPreferences _sharedPreferences;

//   TokenSharedPrefs(this._sharedPreferences);

//   Future<Either<Failure, void>> saveToken(String token) async {
//     try {
//       await _sharedPreferences.setString('token', token);
//       return const Right(null);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   Future<Either<Failure, String>> getToken() async {
//     try {
//       final token = _sharedPreferences.getString('token');
//       return Right(token ?? '');
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  // Save Token
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      bool success = await _sharedPreferences.setString('token', token);
      if (success) {
        return const Right(null);
      } else {
        return const Left(SharedPrefsFailure(message: "Failed to save token."));
      }
    } catch (e) {
      return Left(SharedPrefsFailure(message: "Error saving token: $e"));
    }
  }

  // Retrieve Token
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      if (token == null || token.isEmpty) {
        return const Left(SharedPrefsFailure(message: "No token found."));
      }
      return Right(token);
    } catch (e) {
      return Left(SharedPrefsFailure(message: "Error retrieving token: $e"));
    }
  }

  // Remove Token (Logout)
  // Future<Either<Failure, void>> removeToken() async {
  //   try {
  //     bool success = await _sharedPreferences.remove('token');
  //     if (success) {
  //       return const Right(null);
  //     } else {
  //       return const Left(
  //           SharedPrefsFailure(message: "Failed to remove token."));
  //     }
  //   } catch (e) {
  //     return Left(SharedPrefsFailure(message: "Error removing token: $e"));
  //   }
  // }
}
