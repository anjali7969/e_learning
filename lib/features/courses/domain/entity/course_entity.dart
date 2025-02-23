class CourseEntity {
  final String id;
  final String title;
  final String description;
  final String image;
  final String? videoUrl;

  CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.videoUrl,
  });

  // ✅ Convert JSON to CourseEntity
  factory CourseEntity.fromJson(Map<String, dynamic> json) {
    return CourseEntity(
      id: json['_id'] ?? "", // MongoDB _id field
      title: json['title'] ?? "No title",
      description: json['description'] ?? "No description",
      image: json['image'] ?? "",
      videoUrl: json['videoUrl'], // Nullable field
    );
  }

  // ✅ Convert CourseEntity to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "description": description,
      "image": image,
      "videoUrl": videoUrl,
    };
  }
}
