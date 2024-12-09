import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constant/apilist.dart';
import '../models/feedback_model.dart';
import '../repository/feedback_repository.dart';

// Tạo Dio provider với token authentication
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // Thêm token vào header
      options.headers['Authorization'] = 'Bearer ${token}'; // Lấy token từ nơi bạn lưu trữ
      return handler.next(options);
    },
  ));
  return dio;
});

// Sử dụng dioProvider trong feedbackRepositoryProvider
final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FeedbackRepository(dio);
});

final feedbacksProvider = FutureProvider.autoDispose<List<FeedbackModel>>((ref) async {
  final repository = ref.watch(feedbackRepositoryProvider);
  return repository.getFeedbacks();
});

final feedbackProvider = FutureProvider.family<FeedbackModel, int>((ref, id) async {
  final repository = ref.watch(feedbackRepositoryProvider);
  return repository.getFeedback(id);
});

class FeedbackNotifier extends StateNotifier<AsyncValue<List<FeedbackModel>>> {
  final FeedbackRepository _repository;

  FeedbackNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> getFeedbacks({int page = 1}) async {
    try {
      state = const AsyncValue.loading();
      final feedbacks = await _repository.getFeedbacks(page: page);
      state = AsyncValue.data(feedbacks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createFeedback(FeedbackModel feedback) async {
    try {
      await _repository.createFeedback(feedback);
      getFeedbacks(); // Refresh danh sách sau khi tạo
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFeedbackStatus(int id, String status) async {
    try {
      await _repository.updateFeedbackStatus(id, status);
      getFeedbacks(); // Refresh danh sách sau khi cập nhật
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFeedback(int id) async {
    try {
      await _repository.deleteFeedback(id);
      getFeedbacks(); // Refresh danh sách sau khi xóa
    } catch (e) {
      rethrow;
    }
  }
}

final feedbackNotifierProvider =
    StateNotifierProvider<FeedbackNotifier, AsyncValue<List<FeedbackModel>>>((ref) {
  final repository = ref.watch(feedbackRepositoryProvider);
  return FeedbackNotifier(repository);
});