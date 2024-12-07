import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/apilist.dart';
import '../models/user.dart';
import '../models/response.dart';

class AuthRepository {
  static const String USER_KEY = 'user_data';
  
  final String apiUrl = api_register; 

  Future<Map<String, dynamic>> register(User user) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        if (data['user'] != null) {
          if (data['user']['photo'] == null) {
            data['user']['photo'] = 'assets/default_avatar.png';
          }
          // Lưu user vào local storage
          await _saveUserToLocal(data['user']);
        }
        print('API Response: $data');
        return data;
      } else {
        throw Exception(data['message'] ?? "Failed to register");
      }
    } else {
      throw Exception("Failed to register");
    }
  }

  Future<void> _saveUserToLocal(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_KEY, jsonEncode(userData));
  }

  Future<User?> getUserFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString(USER_KEY);
    if (userStr != null) {
      final userData = jsonDecode(userStr);
      return User.fromJson(userData);
    }
    return null;
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
