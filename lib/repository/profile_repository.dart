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
      final response = await dio.post(
        '/updateprofile',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: profile.toJson(),
      );
      
      return response.statusCode == 200 && response.data['success'] == true;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}
