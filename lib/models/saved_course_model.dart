// file: lib/models/saved_course_model.dart

class SavedCourse {
  final String courseId;
  final String title;
  final String description;
  final String imageUrl;

  SavedCourse({
    required this.courseId,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  // Hàm để chuyển đổi từ JSON sang đối tượng SavedCourse
  factory SavedCourse.fromJson(Map<String, dynamic> json) {
    return SavedCourse(
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  // Hàm để chuyển đổi đối tượng SavedCourse thành JSON
  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
