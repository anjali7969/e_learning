// class CourseDetailsEntity {
//   final String id;
//   final String title;
//   final String description;
//   final String image;
//   final String? videoUrl;
//   final double price;

//   CourseDetailsEntity({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.image,
//     this.videoUrl,
//     required this.price,
//   });

//   // ✅ Convert JSON to CourseDetailsEntity
//   factory CourseDetailsEntity.fromJson(Map<String, dynamic> json) {
//     return CourseDetailsEntity(
//       id: json['_id'] ?? "", // MongoDB _id field
//       title: json['title'] ?? "No title",
//       description: json['description'] ?? "No description",
//       image: json['image'] ?? "",
//       videoUrl: json['videoUrl'], // Nullable field
//       price: (json['price'] as num?)?.toDouble() ?? 0.0, // ✅ Ensure double type
//     );
//   }

//   // ✅ Convert CourseDetailsEntity to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "title": title,
//       "description": description,
//       "image": image,
//       "videoUrl": videoUrl,
//       "price": price,
//     };
//   }
// }
