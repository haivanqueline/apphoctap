import '../constant/apilist.dart';
import '../models/profile.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final dio = Dio(BaseOptions(
    baseUrl: base,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    validateStatus: (status) => true,
  ));

  Future<Profile> getProfile() async {
    try {
      final response = await dio.get('$base/profile', 
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        return Profile.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch profile');
      }
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  Future<bool> updateProfile(Profile profile) async {
    try {
      print('Updating profile with data: ${profile.toJson()}');
      
      // Kiểm tra token
      if (token.isEmpty) {
        print('Token is empty');
        return false;
      }

      final response = await dio.post(
        api_updateprofile, // Sử dụng constant thay vì /updateprofile
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => true, // Cho phép mọi status code
        ),
        data: profile.toJson(),
      );
      
      // Kiểm tra response
      if (response.statusCode == 401) {
        print('Unauthorized - Token may be expired');
        return false;
      }
      
      if (response.headers.value('content-type')?.contains('text/html') ?? false) {
        print('Received HTML response instead of JSON');
        return false;
      }

      print('Update response: ${response.data}');
      return response.statusCode == 200 && 
             response.data is Map && 
             response.data['success'] == true;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}
