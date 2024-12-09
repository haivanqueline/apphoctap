import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/apilist.dart';
import '../models/user.dart';

// Định nghĩa trạng thái cho quá trình đăng nhập
enum LoginStatus { initial, loading, success, error }

// Provider để quản lý trạng thái đăng nhập
class LoginNotifier extends StateNotifier<LoginStatus> {
  LoginNotifier() : super(LoginStatus.initial);

  Future<void> login(String email, String password) async {
    state = LoginStatus.loading;
    final url = Uri.parse(api_login);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String newToken = data['token']['token'];
        
        // Cập nhật token toàn cục
        token = newToken;
        
        // Tạo user object từ response
        final user = User(
          email: data['user']['email'],
          full_name: data['user']['full_name'],
          phone: data['user']['phone'],
          address: data['user']['address'],
          password: password,
          photo: data['user']['photo'] ?? '',
        );
        print('Login successful: $initialProfile');
        // Lưu thông tin user vào SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('current_user', jsonEncode(user.toJson()));
        await prefs.setString('token', newToken);
        
        state = LoginStatus.success;
      } else {
        state = LoginStatus.error;
      }
    } catch (error) {
      state = LoginStatus.error;
    }
  }
}

// Khởi tạo provider cho việc đăng nhập
final loginProvider = StateNotifierProvider<LoginNotifier, LoginStatus>((ref) {
  return LoginNotifier();
});
