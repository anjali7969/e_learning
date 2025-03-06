// import 'package:e_learning/features/courses/data/data_source/course_datasource.dart';
// import 'package:e_learning/features/courses/data/model/course_hive_model.dart';
// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

// import '../../../../../core/network/hive_service.dart';

// class CourseLocalDatasource implements ICourseDataSource {
//   final HiveService _hiveService;

//   CourseLocalDatasource(this._hiveService);

//   // @override
//   // Future<void> createProduct(ProductEntity productEntity) async {
//   //   try {
//   //     final productHiveModel = ProductHiveModel.fromEntity(productEntity);
//   //     await _hiveService.addProduct(productHiveModel);
//   //   } catch (e) {
//   //     throw Exception('Error creating product: $e');
//   //   }
//   // }

//   // @override
//   // Future<void> deleteProduct(String id, String? token) async {
//   //   try {
//   //     await _hiveService.deleteProduct(id);
//   //   } catch (e) {
//   //     throw Exception('Error deleting product: $e');
//   //   }
//   // }

//   @override
//   Future<List<CourseEntity>> getAllCourses() async {
//     try {
//       final courses = await _hiveService.getAllCourses();
//       return courses.map((e) => e.toEntity()).toList();
//     } catch (e) {
//       throw Exception('Error fetching all products: $e');
//     }
//   }

//   @override
//   Future<CourseHiveModel?> getCourseById(String courseId) async {
//     try {
//       final courseHiveModel = await _hiveService.getCourseById(courseId);
//       return courseHiveModel;
//     } catch (e) {
//       throw Exception('Error fetching product by ID: $e');
//     }
//   }

//   // @override
//   // Future<void> updateProduct(ProductEntity productEntity) async {
//   //   try {
//   //     final productHiveModel = ProductHiveModel.fromEntity(productEntity);
//   //     await _hiveService.updateProduct(productHiveModel);
//   //   } catch (e) {
//   //     throw Exception('Error updating product: $e');
//   //   }
//   // }
// }
