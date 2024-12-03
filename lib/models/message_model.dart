import '../models/user.dart';

class Message {
  final int id;
  final User sender;
  final User receiver;
  final String content;
  final String status;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.status,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']), 
      content: json['content'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'content': content,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}