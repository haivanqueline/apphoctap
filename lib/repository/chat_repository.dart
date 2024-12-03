import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/message_model.dart';
import '../constant/apilist.dart';

class ChatRepository {
  final dio = Dio(BaseOptions(
    baseUrl: base,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    validateStatus: (status) => true,
  ));

  Future<Message> sendMessage(User receiver, String content) async {
    try {
      final response = await dio.post(
        api_send_message,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'receiver_id': receiver.id,
          'content': content,
        },
      );


      if (response.statusCode == 200) {
        return Message(
          id: response.data['data']['id'] ?? 0,
          content: content,
          sender: User.fromJson(response.data['data']['sender'] ?? {}),
          receiver: receiver,
          createdAt: DateTime.now(),
          status: 'sent',
        );
      }
      throw Exception(response.data['message'] ?? 'Failed to send message');
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  Future<List<Message>> getMessages(User otherUser) async {
    try {
      final response = await dio.get(
        '$api_get_messages/${otherUser.id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );


      if (response.statusCode == 200) {
        final List<dynamic> messages = response.data['data']['data'] ?? [];
        return messages.map((messageData) {
          
          try {
            return Message(
              id: messageData['id'] ?? 0,
              content: messageData['content'] ?? '',
              sender: User(id: messageData['sender_id'], full_name: '', email: '', password: '', phone: '', address: ''),
              receiver: User(id: messageData['receiver_id'], full_name: '', email: '', password: '', phone: '', address: ''),
              status: messageData['status'] ?? 'sent',
              createdAt: DateTime.parse(messageData['created_at'] ?? DateTime.now().toIso8601String()),
            );
          } catch (e) {
            
            rethrow;
          }
        }).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }

  Future<bool> deleteMessage(int messageId) async {
    try {
      final response = await dio.delete(
        '$api_delete_message/$messageId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }
}
