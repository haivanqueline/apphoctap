import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedCoursesScreen extends StatefulWidget {
  @override
  _SavedCoursesScreenState createState() => _SavedCoursesScreenState();
}

class _SavedCoursesScreenState extends State<SavedCoursesScreen> {
  List<String> savedCourses = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCourses();
  }

  // Tải danh sách các khóa học đã lưu từ SharedPreferences
  Future<void> _loadSavedCourses() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedCourses = prefs.getStringList('saved_courses') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Courses'),
      ),
      body: savedCourses.isEmpty
          ? Center(child: Text('No saved courses'))
          : ListView.builder(
              itemCount: savedCourses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(savedCourses[index]), // Tên khóa học
                );
              },
            ),
    );
  }
}
