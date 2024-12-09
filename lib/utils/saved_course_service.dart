import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCourse(String courseId) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> savedCourses = prefs.getStringList('saved_courses') ?? [];
  savedCourses.add(courseId); // Lưu ID khóa học
  prefs.setStringList('saved_courses', savedCourses);
}

// Hàm kiểm tra khóa học đã lưu hay chưa
Future<bool> isCourseSaved(String courseId) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> savedCourses = prefs.getStringList('saved_courses') ?? [];
  return savedCourses.contains(courseId);
}
