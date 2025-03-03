import 'package:equatable/equatable.dart';

/// **📌 Course Entity Model**
class CourseEntity extends Equatable {
  final String? id;
  final String title;
  final String description;
  final String image;
  final double price;
  final String? videoUrl;

  const CourseEntity({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    this.videoUrl,
  });

  /// **✅ Initialize Empty Constructor**
  const CourseEntity.empty()
      : id = '_empty.id',
        title = '_empty.title',
        description = '_empty.description',
        image = '_empty.image',
        price = 0.0,
        videoUrl = null;

  /// **✅ Convert JSON to Course Entity**
  factory CourseEntity.fromJson(Map<String, dynamic> json) {
    return CourseEntity(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      videoUrl: json['videoUrl'],
    );
  }

  /// **✅ Convert Course Entity to JSON**
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "description": description,
      "image": image,
      "price": price,
      "videoUrl": videoUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        price,
        videoUrl,
      ];
}
