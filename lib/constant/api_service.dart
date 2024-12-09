import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_megnagmet/models/my_cource.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/v1";

  Future<List<OngoingCources>> fetchOngoingCourses() async {
    final url = Uri.parse('$baseUrl/khoahoc');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => OngoingCources.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

Future<List<OngoingCources>> searchCourses(String query) async {
  final response = await http.get(
    Uri.parse('$baseUrl/khoa-hocs?search=$query'),
    headers: {
      'Accept': 'application/json',  // Chỉ rõ yêu cầu nhận JSON
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];

    if (data.isEmpty) {
      print('No courses found for query: $query');
      return [];  // Trả về mảng rỗng khi không tìm thấy khóa học
    }

    return data.map((e) => OngoingCources.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load courses');
  }
}

}