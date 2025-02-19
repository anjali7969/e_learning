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
}
