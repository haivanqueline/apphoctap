import 'package:dio/dio.dart';
import '../models/user.dart';
import '../constant/apilist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final dio = Dio(BaseOptions(
    baseUrl: base,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));

  Future<List<User>> getUsers() async {
    try {
      final response = await dio.get(
        '/users',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final userData = response.data['data'];
        if (userData == null || userData['data'] == null) {
          return [];
        }
        final List<dynamic> users = userData['data'];
        return users
            .where((json) =>
                json != null &&
                json['email'] != null &&
                json['full_name'] != null)
            .map((json) => User.fromJson(json))
            .toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<List<User>> searchUsers(String query) async {
    try {
      final response = await dio.get(
        '/users/search',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        final userData = response.data['data'];
        if (userData == null || userData['data'] == null) {
          return [];
        }
        final List<dynamic> users = userData['data'];
        return users
            .where((json) =>
                json != null &&
                json['email'] != null &&
                json['full_name'] != null)
            .map((json) => User.fromJson(json))
            .toList();
      } else {
        throw Exception(
            response.data['message'] ?? 'Không tìm thấy người dùng');
      }
    } catch (e) {
      throw Exception('Lỗi khi tìm kiếm: $e');
    }
  }
}

// Định nghĩa userRepositoryProvider
final userRepositoryProvider = Provider((ref) => UserRepository());