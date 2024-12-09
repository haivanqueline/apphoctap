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
      
      if (response.statusCode == 200) {
        return Profile.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to fetch profile');
      }
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  Future<bool> updateProfile(Profile profile) async {
    try {
      print('Updating profile with data: ${profile.toJson()}');
      
      final response = await dio.post(
        '/updateprofile',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'email': profile.email,
          'full_name': profile.full_name,
          'phone': profile.phone,
          'address': profile.address,
          'avatar_url': profile.photo,
        },
      );
      
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      
      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Dio error type: ${e.type}');
      print('Dio error message: ${e.message}');
      return false;
    }
  }
}
