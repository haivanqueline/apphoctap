import 'package:flutter/material.dart';
import 'api_service.dart';
import 'lecturer.dart';
class LecturerDetail extends StatelessWidget {
  final int id;
  LecturerDetail({required this.id});
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Chi tiết giảng viên'),
    ),
    body: FutureBuilder<Lecturer>(
      future: ApiService().fetchLecturerById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Không tìm thấy giảng viên'));
        } else {
          Lecturer lecturer = snapshot.data!;
          print('Lecturer info: ${lecturer.name}, ${lecturer.email}');  // In ra để kiểm tra
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mã GV: ${lecturer.magv}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Họ tên: ${lecturer.name}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Email: ${lecturer.email}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Số điện thoại: ${lecturer.phoneNumber}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Khoa: ${lecturer.faculty}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Chuyên ngành: ${lecturer.major}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Học vị: ${lecturer.degree}', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        }
      },
    ),
  );
}
}