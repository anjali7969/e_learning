// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:uuid/uuid.dart';

// import '../../../../app/constants/hive_table_constant.dart';

// part 'course_hive_model.g.dart';

// /// **📌 Course Hive Model for Local Storage**
// @HiveType(typeId: HiveTableConstant.courseTableId)
// class CourseHiveModel extends Equatable {
//   @HiveField(0)
//   final String? id;

//   @HiveField(1)
//   final String title;

//   @HiveField(2)
//   final String description;

//   @HiveField(3)
//   final String? image;

//   @HiveField(4)
//   final double price;

//   CourseHiveModel({
//     String? id,
//     required this.title,
//     required this.description,
//     this.image,
//     required this.price,
//   }) : id = id ?? const Uuid().v4();

//   /// **✅ Initial Constructor**
//   const CourseHiveModel.initial()
//       : id = '',
//         title = '',
//         description = '',
//         image = '',
//         price = 0.0;

//   /// **✅ Convert from Entity to Hive Model**
//   factory CourseHiveModel.fromEntity(CourseEntity entity) {
//     return CourseHiveModel(
//       id: entity.id,
//       title: entity.title,
//       description: entity.description,
//       image: entity.image,
//       price: entity.price,
//     );
//   }

//   /// **✅ Convert from Hive Model to Entity**
//   CourseEntity toEntity() {
//     return CourseEntity(
//       id: id ?? '',
//       title: title,
//       description: description,
//       image: image ?? '',
//       price: price,
//     );
//   }

//   /// **✅ Convert Entity List to Hive Model List**
//   static List<CourseHiveModel> fromEntityList(List<CourseEntity> entityList) {
//     return entityList
//         .map((entity) => CourseHiveModel.fromEntity(entity))
//         .toList();
//   }

//   @override
//   List<Object?> get props => [id, title, description, image, price];
// }
