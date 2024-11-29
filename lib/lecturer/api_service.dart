// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'lecturer.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/v1"; // URL API Laravel

  // Lấy danh sách giảng viên
  Future<List<Lecturer>> fetchLecturers() async {
    final response = await http.get(Uri.parse('$baseUrl/lecturers'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((lecturer) => Lecturer.fromJson(lecturer)).toList();
    } else {
      throw Exception('Failed to load lecturers');
    }
  }

  // Lấy giảng viên theo ID
  Future<Lecturer> fetchLecturerById(int id) async {
  final response = await http.get(Uri.parse('$baseUrl/lecturers/$id'));
  if (response.statusCode == 200) {
    print(json.decode(response.body));  // In dữ liệu nhận được
    return Lecturer.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load lecturer');
  }
}
}
