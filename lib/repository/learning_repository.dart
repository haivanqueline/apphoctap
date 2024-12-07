import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../constant/apilist.dart';
import '../models/khoa_hoc.dart';
import '../models/bai_hoc.dart';
import 'dart:typed_data';

class LearningRepository {
  Future<http.Response> getAllCourses() async {
    final response = await http.get(
      Uri.parse(api_get_courses),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('Request URL: ${Uri.parse(api_get_courses)}');
    return response;
  }

  Future<http.Response> uploadLesson(BaiHoc baiHoc, {
    Uint8List? videoBytes,
    String? videoName,
    List<PlatformFile>? documentFiles,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(api_upload_lesson),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    request.fields.addAll({
      'ten_bai_hoc': baiHoc.tenBaiHoc,
      'mo_ta': baiHoc.moTa ?? '',
      'id_khoahoc': baiHoc.idKhoahoc.toString(),
      'noi_dung': baiHoc.noiDung ?? '',
      'thu_tu': baiHoc.thuTu.toString(),
      'trang_thai': baiHoc.trangThai,
    });

    if (videoBytes != null && videoName != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'video',
          videoBytes,
          filename: videoName,
        ),
      );
    }

    if (documentFiles != null) {
      for (var file in documentFiles) {
        if (file.bytes != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'tai_lieu[]',
              file.bytes!,
              filename: file.name,
            ),
          );
        }
      }
    }

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> getLessonContent(int khoaHocId) async {
    try {
      final response = await http.get(
        Uri.parse('$api_get_lesson_content/$khoaHocId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('API Response: ${response.body}');
      return response;
    } catch (e) {
      print('Repository Error: $e');
      rethrow;
    }
  }

  Future<http.Response> createCourse(KhoaHoc khoaHoc, {
    Uint8List? thumbnailBytes,
    String? thumbnailName,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(api_create_course),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    request.fields.addAll({
      'ten_khoa_hoc': khoaHoc.tenKhoaHoc,
      'mo_ta': khoaHoc.moTa ?? '',
      'gia': khoaHoc.gia.toString(),
      'trang_thai': khoaHoc.trangThai,
    });

    if (thumbnailBytes != null && thumbnailName != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'thumbnail',
          thumbnailBytes,
          filename: thumbnailName,
        ),
      );
    }

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> getLessonDetail(int baiHocId) async {
    try {
      final response = await http.get(
        Uri.parse('$api_get_lesson_detail/$baiHocId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      print('Repository Error: $e');
      rethrow;
    }
  }

  Future<http.Response> getLearningProgress(int khoaHocId) async {
    try {
      final response = await http.get(
        Uri.parse('$api_get_learning_progress/$khoaHocId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      print('Repository Error: $e');
      rethrow;
    }
  }
}
