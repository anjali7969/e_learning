class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:3000/";

  //For iphone
  // static const String baseUrl = "http://localhost:3000/api/v1";

  // ======================= Auth Routes =========================
  static const String login = "user/login";
  static const String register = "user/register";
  // static const String getAllStudent = "auth/getAllStudents";
  // static const String getStudentByBatch = "auth/getstudentByBatch/";
  // static const String getStudentByCourse = "auth/getstudentByCourse/";
  // static const String updateStudent = "auth/updateStudent/";
  // static const String deleteStudent = "auth/deleteStudent/";
  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  // static const String uploadImage = "auth/uploadImage";
}
