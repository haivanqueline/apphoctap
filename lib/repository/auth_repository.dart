import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constant/apilist.dart';
import '../models/user.dart';
import '../models/response.dart';

class AuthRepository {
  final String apiUrl = api_register; 

  Future<User> register(User user) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return User.fromJson(data['user']);
      } else {
        throw Exception(data['message'] ?? "Failed to register");
      }
    } else {
      throw Exception("Failed to register");
    }
  }

  Future<Response> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(api_login),
        body: {
          'email': email,
          'password': password,
        },
      ).timeout(Duration(seconds: 30)); // Thêm timeout
      
      if (response.statusCode == 200) {
        return Response.success(response);
      } else {
        return Response.error("Đăng nhập thất bại");
      }
    } catch (e) {
      return Response.error("Lỗi kết nối: $e");
    }
  }
}
