import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message_model.dart';
import '../models/user.dart';
import '../repository/chat_repository.dart';

class ChatState {
  final List<Message> messages;
  final bool isLoading;
  final String? error;

  ChatState({
    required this.messages,
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository _repository;

  ChatNotifier(this._repository) : super(ChatState(messages: []));

  Future<void> sendMessage(User receiver, String content) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final message = await _repository.sendMessage(receiver, content);
      
      // Thêm tin nhắn mới vào đầu danh sách
      state = state.copyWith(
        messages: [message, ...state.messages],
        isLoading: false,
      );
      
      // Refresh lại danh sách tin nhắn
      await loadMessages(receiver);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> loadMessages(User otherUser) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final messages = await _repository.getMessages(otherUser);
      state = state.copyWith(
        messages: messages,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> deleteMessage(int messageId) async {
    try {
      final success = await _repository.deleteMessage(messageId);
      if (success) {
        state = state.copyWith(
          messages: state.messages.where((m) => m.id != messageId).toList(),
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final chatRepositoryProvider = Provider((ref) => ChatRepository());

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatNotifier(repository);
});