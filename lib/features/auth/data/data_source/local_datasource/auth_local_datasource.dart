// import 'dart:io';

// import 'package:e_learning/core/network/hive_service.dart';
// import 'package:e_learning/features/auth/data/data_source/auth_data_source.dart';
// import 'package:e_learning/features/auth/data/model/auth_hive_model.dart';
// import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
// import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';

// class AuthLocalDataSource implements IAuthDataSource {
//   final HiveService _hiveService;

//   AuthLocalDataSource(this._hiveService);

//   @override
//   Future<AuthEntity> getCurrentUser() {
//     // Return Empty AuthEntity
//     return Future.value(const AuthEntity(
//       userId: "1",
//       name: "",
//       phone: "",
//       email: "",
//       image: "",
//       password: "",
//     ));
//   }

//   @override
//   Future<AuthResponse> loginUser(String username, String password) async {
//     try {
//       final AuthHiveModel? user = await _hiveService.login(username, password);

//       if (user != null) {
//         if (user.studentId == null || user.studentId!.isEmpty) {
//           throw Exception("Invalid user data: Missing studentId.");
//         }

//         return Future.value(AuthResponse(
//           token: 'local_token_${user.studentId}', // Dummy token
//           userId: user.studentId!, // Use ! to force non-null value
//           name: user.name,
//           email: user.email,
//           role: "User", // Assign a default role
//         ));
//       } else {
//         throw Exception("Invalid username or password.");
//       }
//     } catch (e) {
//       return Future.error('Login failed: $e');
//     }
//   }

//   @override
//   Future<void> registerUser(AuthEntity user) async {
//     try {
//       // Convert AuthEntity to AuthHiveModel
//       final authHiveModel = AuthHiveModel.fromEntity(user);

//       await _hiveService.register(authHiveModel);
//       return Future.value();
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<String> uploadProfilePicture(File file) {
//     throw UnimplementedError();
//   }
// }
