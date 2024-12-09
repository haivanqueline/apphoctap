import 'package:dio/dio.dart';
import '../models/feedback_model.dart';
import '../constant/apilist.dart';

class FeedbackRepository {
  final Dio _dio;

  FeedbackRepository(this._dio);

  Future<List<FeedbackModel>> getFeedbacks({int page = 1}) async {
    try {
      final response = await _dio.get(
        api_feedbacks, 
        queryParameters: {'page': page}
      );
      
      if (response.data['status'] == 'success') {
        final List feedbacksData = response.data['data']['data'] ?? [];
        return feedbacksData.map((json) => FeedbackModel.fromJson(json)).toList();
      }
      return []; // Trả về list rỗng nếu không có data
    } catch (e) {
      print('Error getting feedbacks: $e'); // Thêm log để debug
      return []; // Trả về list rỗng trong trường hợp lỗi
    }
  }

  Future<FeedbackModel> createFeedback(FeedbackModel feedback) async {
    try {
      print('Request URL: ${api_feedbacks}'); // Log URL
      print('Request Headers: ${_dio.options.headers}'); // Log headers
      print('Request Data: ${feedback.toJson()}'); // Log data being sent

      final response = await _dio.post(
        api_feedbacks,
        data: feedback.toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${_dio.options.headers['Authorization']}', // Đảm bảo gửi token
          },
          validateStatus: (status) {
            return status! < 500; // Chấp nhận status code dưới 500
          },
        ),
      );

      print('Response Status: ${response.statusCode}'); // Log response status
      print('Response Headers: ${response.headers}'); // Log response headers
      print('Response Data: ${response.data}'); // Log response data

      if (response.statusCode == 201 || response.statusCode == 200) {
        return FeedbackModel.fromJson(response.data['data']);
      }

      // Log chi tiết nếu có lỗi
      print('Error Response: ${response.data}');
      throw Exception(response.data['message'] ?? 'Không thể tạo feedback');
    } on DioException catch (e) {
      print('DioError Type: ${e.type}');
      print('DioError Message: ${e.message}');
      print('DioError Response: ${e.response?.data}');
      print('DioError StackTrace: ${e.stackTrace}');
      throw Exception('Lỗi khi tạo feedback: ${e.response?.data?['message'] ?? e.message}');
    } catch (e, stackTrace) {
      print('Other Error: $e');
      print('StackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<FeedbackModel> getFeedback(int id) async {
    try {
      final response = await _dio.get('$api_feedbacks/$id');
      
      if (response.data['status'] == 'success') {
        return FeedbackModel.fromJson(response.data['data']);
      }
      throw Exception('Không thể tải feedback');
    } catch (e) {
      throw Exception('Lỗi khi tải feedback: $e');
    }
  }

  Future<FeedbackModel> updateFeedbackStatus(int id, String status) async {
    try {
      final response = await _dio.patch(
        '$api_feedback_status/$id/status',
        data: {'status': status},
      );

      if (response.data['status'] == 'success') {
        return FeedbackModel.fromJson(response.data['data']);
      }
      throw Exception('Không thể cập nhật trạng thái feedback');
    } catch (e) {
      throw Exception('Lỗi khi cập nhật trạng thái: $e');
    }
  }

  Future<void> deleteFeedback(int id) async {
    try {
      final response = await _dio.delete('$api_feedback_status/$id');
      
      if (response.data['status'] != 'success') {
        throw Exception('Không thể xóa feedback');
      }
    } catch (e) {
      throw Exception('Lỗi khi xóa feedback: $e');
    }
  }
}