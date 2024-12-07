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
}