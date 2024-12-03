import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/message_model.dart';
import '../models/user.dart';
import '../providers/chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final User receiver;
  const ChatScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  int? currentUserId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserId();
  }

  Future<void> _loadCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');
    
    if (userJson != null) {
      final user = User.fromJson(jsonDecode(userJson));
      setState(() {
        currentUserId = user.id;
      });
      _loadMessages();
    }
  }

  void _loadMessages() {
    ref.read(chatProvider.notifier).loadMessages(widget.receiver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 79.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/back_arrow.png",
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                SizedBox(width: 20.w),
                CircleAvatar(
                  radius: 27.5.w,
                  backgroundImage: NetworkImage(widget.receiver.photo),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.receiver.full_name,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: buildMessagesList(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 64.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Your message',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 21.w,
                          vertical: 15.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Icon(Icons.send, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessagesList() {
    final chatState = ref.watch(chatProvider);
    
    if (chatState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      reverse: true,
      itemCount: chatState.messages.length,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemBuilder: (context, index) {
        final message = chatState.messages[index];
        final isMe = currentUserId == message.sender.id;
  
        
        return _buildMessageBubble(message, isMe);
      },
    );
  }

  Widget _buildMessageBubble(Message message, bool isMe) {
    String formatTime(DateTime dateTime) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (messageDate == today) {
        return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else if (messageDate == today.subtract(Duration(days: 1))) {
        return 'Hôm qua ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else {
        return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundImage: NetworkImage(message.sender.photo),
            ),
            SizedBox(width: 8.w),
          ],
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isMe ? Color(0xFF0084FF) : Color(0xFFE4E6EB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r),
                    bottomLeft: Radius.circular(isMe ? 18.r : 4.r),
                    bottomRight: Radius.circular(isMe ? 4.r : 18.r),
                  ),
                ),
                child: Text(
                  message.content,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                formatTime(message.createdAt),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          if (isMe) ...[
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 16.r,
              backgroundImage: NetworkImage(message.sender.photo),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty && currentUserId != null) {
      await ref.read(chatProvider.notifier).sendMessage(
        widget.receiver,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
