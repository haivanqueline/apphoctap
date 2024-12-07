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
        if (data['success'] == true) {
          String newToken = data['token']['token'];
          token = newToken;
          
          final user = User.fromJson(data['user']);
          
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('current_user', jsonEncode(user.toJson()));
          await prefs.setString('token', newToken);
          
          state = LoginStatus.success;
        } else {
          state = LoginStatus.error;
          throw Exception(data['message']);
        }
      } else {
        state = LoginStatus.error;
        throw Exception('Failed to authenticate');
      }
    } catch (error) {
      state = LoginStatus.error;
      throw error;
    }
  }
}

// Khởi tạo provider cho việc đăng nhập
final loginProvider = StateNotifierProvider<LoginNotifier, LoginStatus>((ref) {
  return LoginNotifier();
});
