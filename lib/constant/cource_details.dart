import 'package:learn_megnagmet/models/ongoing_cource_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CourceDetailsService {
  static const String _apiUrl = 'http://127.0.0.1:8000/api/v1/baihoc';

  Future<List<CourceDetails>> fetchLessons() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        // Kiểm tra dữ liệu trả về
        if (data != null) {
          return data.map((json) => CourceDetails.fromJson(json)).toList();
        } else {
          throw Exception('No data found');
        }
      } else {
        throw Exception('Failed to load lessons');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
