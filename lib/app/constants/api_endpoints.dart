class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:5003/";

  //For iphone
  // static const String baseUrl = "http://localhost:3000/api/v1";

  // ======================= Auth Routes =========================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getCurrentUser = "auth/getCurrentUser";
  // static const String getStudentByBatch = "auth/getstudentByBatch/";
  // static const String getStudentByCourse = "auth/getstudentByCourse/";
  // static const String updateStudent = "auth/updateStudent/";
  // static const String deleteStudent = "auth/deleteStudent/";
  static const String imageUrl = "http://10.0.2.2:5003/uploads/";
  static const String uploadImage = "auth/uploadImage";

  // ✅ Course Routes
  static const String getAllCourses = "courses/all"; // <-- Fetch all courses

  // ✅ Image Path
  static const String imageUrl1 = "${baseUrl}uploads/";
}
