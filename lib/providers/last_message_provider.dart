import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message_model.dart';
import '../repository/chat_repository.dart';
import '../models/user.dart';

final lastMessageProvider = StateNotifierProvider<LastMessageNotifier, Map<int, Message>>((ref) {
  return LastMessageNotifier();
});

class LastMessageNotifier extends StateNotifier<Map<int, Message>> {
  LastMessageNotifier() : super({});

  Future<void> loadLastMessage(User user) async {
    try {
      final messages = await ChatRepository().getMessages(user);
      if (messages.isNotEmpty) {
        state = {...state, user.id: messages.first};
      }
    } catch (e) {
      print('Error loading last message: $e');
    }
  }
} 