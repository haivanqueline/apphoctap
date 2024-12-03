import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_megnagmet/utils/screen_size.dart';
import '../models/user.dart';
import '../providers/chat_provider.dart';
import '../repository/user_repository.dart';
import 'detail_chate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../providers/last_message_provider.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  late Future<List<User>> _users;
  int? currentUserId;
  final TextEditingController _searchController = TextEditingController();
  List<User> filteredUsers = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _users = ref.read(userRepositoryProvider).getUsers();
  }

  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');
    if (userJson != null) {
      final user = User.fromJson(jsonDecode(userJson));
      setState(() {
        currentUserId = user.id;
      });
    }
  }

  void _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        _users = ref.read(userRepositoryProvider).getUsers();
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    try {
      final results = await ref.read(userRepositoryProvider).searchUsers(query);
      setState(() {
        filteredUsers = results;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Message!!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0XFF23408F),
        child: Image(
          image: AssetImage("assets/floatingaction.png"),
          height: 24.h,
          width: 24.w,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: TextField(
              controller: _searchController,
              onChanged: _searchUsers,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm người dùng',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  borderSide: BorderSide(color: Color(0XFFDEDEDE)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  borderSide: BorderSide(color: Color(0XFF23408F)),
                ),
              ),
            ),
          ),
          Expanded(
            child: isSearching ? _buildSearchResults() : _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        if (user.id == currentUserId) return Container();
        return UserListTile(user: user);
      },
    );
  }

  Widget _buildUserList() {
    return FutureBuilder<List<User>>(
      future: _users,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
        }

        final users = snapshot.data ?? [];
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            if (user.id == currentUserId) return Container();
            return UserListTile(user: user);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class UserListTile extends ConsumerStatefulWidget {
  final User user;

  const UserListTile({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends ConsumerState<UserListTile> {
  @override
  void initState() {
    super.initState();
    ref.read(lastMessageProvider.notifier).loadLastMessage(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    final lastMessages = ref.watch(lastMessageProvider);
    final lastMessage = lastMessages[widget.user.id];

    return GestureDetector(
      onTap: () => _openChat(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Container(
          height: 70.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0XFF23408F).withOpacity(0.14),
                offset: const Offset(-4, 5),
                blurRadius: 16.h,
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              _buildAvatar(),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.full_name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                    SizedBox(height: 2.h),
                    if (lastMessage != null) ...[
                      Text(
                        lastMessage.content,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0XFF6E758A),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _formatTime(lastMessage.createdAt),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ] else
                      Text(
                        'Bắt đầu cuộc trò chuyện',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0XFF6E758A),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(Duration(days: 1))) {
      return 'Hôm qua';
    } else {
      return '${dateTime.day}/${dateTime.month}';
    }
  }

  Widget _buildAvatar() {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: widget.user.photo.isNotEmpty
              ? NetworkImage(widget.user.photo)
              : const AssetImage("assets/default_avatar.png") as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _openChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProviderScope(
          child: ChatScreen(receiver: widget.user),
        ),
      ),
    );
  }
}
