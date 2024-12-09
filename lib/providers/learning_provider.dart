import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../repository/learning_repository.dart';
import '../models/khoa_hoc.dart';
import '../models/bai_hoc.dart';

class LearningProvider with ChangeNotifier {
  final LearningRepository _learningRepository = LearningRepository();
  bool _isLoading = false;
  bool _isLoadingLessons = false;
  List<KhoaHoc> _myCourses = [];
  List<BaiHoc> _lessons = [];
  String? _error;
  bool _isFirstLoad = true;
  List<KhoaHoc> _savedCourses = [];
  List<KhoaHoc> _searchResults = [];

  bool get isLoading => _isLoading;
  bool get isLoadingLessons => _isLoadingLessons;
  List<KhoaHoc> get myCourses => _myCourses;
  List<BaiHoc> get lessons => _lessons;
  String? get error => _error;
  List<KhoaHoc> get savedCourses => _savedCourses;
  List<KhoaHoc> get searchResults => _searchResults;

  Future<void> fetchMyCourses() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.getAllCourses();
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          if (responseData['data'] != null) {
            final List<dynamic> coursesData = responseData['data'];
            _myCourses = coursesData.map((json) {
              if (json['created_by_name'] == null && json['user'] != null) {
                json['created_by_name'] = json['user']['full_name'] ?? 'Không xác định';
              }
              return KhoaHoc.fromJson(json);
            }).toList();
            _isFirstLoad = false;
            print('Loaded ${_myCourses.length} courses');
          } else {
            _myCourses = [];
          }
        } else {
          _error = responseData['message'] ?? 'Không thể tải danh sách khóa học';
        }
      } else {
        _error = 'Không thể tải danh sách khóa học';
      }
    } catch (e) {
      print('Error fetching courses: $e');
      _error = 'Lỗi kết nối: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLessonContent(int khoaHocId) async {
    try {
      _isLoadingLessons = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.getLessonContent(khoaHocId);
      print('Lesson Response status: ${response.statusCode}');
      print('Lesson Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          final List<dynamic> lessonsData = responseData['data'];
          print('Parsing lessons data: $lessonsData');

          _lessons = lessonsData.map((json) {
            if (json['id_khoahoc'] is String) {
              json['id_khoahoc'] = int.parse(json['id_khoahoc']);
            }
            return BaiHoc.fromJson(json);
          }).toList();

          _lessons.sort((a, b) => a.thuTu.compareTo(b.thuTu));
          print('Loaded ${_lessons.length} lessons for course $khoaHocId');

          _lessons.forEach((lesson) {
            print(
                'Lesson ID: ${lesson.id}, Name: ${lesson.tenBaiHoc}, CourseID: ${lesson.idKhoahoc}');
          });
        } else {
          _lessons = [];
          print('No lessons data found in response');
        }
      } else {
        _error = 'Không thể tải danh sách bài học';
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error fetching lessons: $e');
      _error = 'Lỗi khi tải bài học: $e';
    } finally {
      _isLoadingLessons = false;
      notifyListeners();
    }
  }

  Future<BaiHoc?> getLessonDetail(int baiHocId) async {
    try {
      _error = null;
      final response = await _learningRepository.getLessonDetail(baiHocId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          return BaiHoc.fromJson(responseData['data']);
        }
      }
      return null;
    } catch (e) {
      _error = 'Lỗi: $e';
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getLearningProgress(int khoaHocId) async {
    try {
      _error = null;
      final response = await _learningRepository.getLearningProgress(khoaHocId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] is List) {
          return List<Map<String, dynamic>>.from(responseData['data']);
        }
      }
      return [];
    } catch (e) {
      _error = 'Lỗi: $e';
      return [];
    }
  }

  Future<KhoaHoc?> createCourse(
    KhoaHoc khoaHoc, {
    Uint8List? thumbnailBytes,
    String? thumbnailName,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.createCourse(
        khoaHoc,
        thumbnailBytes: thumbnailBytes,
        thumbnailName: thumbnailName,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          final newCourse = KhoaHoc.fromJson(responseData['data']);
          await fetchMyCourses();
          return newCourse;
        } else {
          _error = responseData['message'] ?? 'Không thể tạo khóa học';
          throw Exception(_error);
        }
      } else {
        _error = 'Lỗi server: ${response.statusCode}';
        throw Exception(_error);
      }
    } catch (e) {
      _error = 'Lỗi: $e';
      print('Error creating course: $_error');
      throw Exception(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<BaiHoc?> uploadLesson(
    BaiHoc baiHoc, {
    Uint8List? videoBytes,
    String? videoName,
    List<PlatformFile>? documentFiles,
  }) async {
    try {
      _isLoadingLessons = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.uploadLesson(
        baiHoc,
        videoBytes: videoBytes,
        videoName: videoName,
        documentFiles: documentFiles,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          final data = responseData['data'];
          if (data['thu_tu'] is String) {
            data['thu_tu'] = int.parse(data['thu_tu']);
          }
          if (data['id_khoahoc'] is String) {
            data['id_khoahoc'] = int.parse(data['id_khoahoc']);
          }

          final newLesson = BaiHoc.fromJson(data);
          await fetchLessonContent(baiHoc.idKhoahoc);
          return newLesson;
        }
      }
      _error = 'Không thể tạo bài học';
      return null;
    } catch (e) {
      _error = 'Lỗi: $e';
      print('Error uploading lesson: $e');
      return null;
    } finally {
      _isLoadingLessons = false;
      notifyListeners();
    }
  }

  Future<void> refreshCourses() async {
    _isFirstLoad = true;
    await fetchMyCourses();
  }

  Future<bool> deleteCourse(int khoaHocId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.deleteCourse(khoaHocId);

      print('Delete course response status: ${response.statusCode}');
      print('Delete course response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          _myCourses.removeWhere((course) => course.id == khoaHocId);
          notifyListeners();
          return true;
        }
      }
      _error = 'Không thể xóa khóa học';
      return false;
    } catch (e) {
      print('Error deleting course: $e');
      _error = 'Lỗi khi xóa khóa học: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteLesson(int baiHocId, int khoaHocId) async {
    try {
      _isLoadingLessons = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.deleteLesson(baiHocId);

      print('Delete lesson response status: ${response.statusCode}');
      print('Delete lesson response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          await fetchLessonContent(khoaHocId);
          return true;
        }
      }
      _error = 'Không thể xóa bài học';
      return false;
    } catch (e) {
      print('Error deleting lesson: $e');
      _error = 'Lỗi khi xóa bài học: $e';
      return false;
    } finally {
      _isLoadingLessons = false;
      notifyListeners();
    }
  }

  Future<bool> saveCourse(int khoaHocId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.saveCourse(khoaHocId);

      print('Save course response status: ${response.statusCode}');
      print('Save course response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          await fetchSavedCourses(); // Refresh danh sách khóa học đã lưu
          return true;
        }
      }
      _error = 'Không thể lưu khóa học';
      return false;
    } catch (e) {
      print('Error saving course: $e');
      _error = 'Lỗi khi lưu khóa học: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSavedCourses() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.getSavedCourses();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          final List<dynamic> coursesData = responseData['data'];
          _savedCourses =
              coursesData.map((json) => KhoaHoc.fromJson(json)).toList();
        } else {
          _savedCourses = [];
        }
      } else {
        _error = 'Không thể tải danh sách khóa học đã lưu';
      }
    } catch (e) {
      print('Error fetching saved courses: $e');
      _error = 'Lỗi khi tải khóa học đã lưu: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCourses({
    String? keyword,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _learningRepository.searchCourses(
        keyword: keyword,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortBy: sortBy,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          final List<dynamic> coursesData = responseData['data'];
          _searchResults = coursesData.map((json) => KhoaHoc.fromJson(json)).toList();
        } else {
          _searchResults = [];
        }
      } else {
        _error = 'Không thể tìm kiếm khóa học';
      }
    } catch (e) {
      print('Error searching courses: $e');
      _error = 'Lỗi khi tìm kiếm khóa học: $e';
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }
}
