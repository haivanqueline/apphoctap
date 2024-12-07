import 'package:flutter/material.dart';
import 'package:learn_megnagmet/lecturer/lecturerdetail.dart';
import 'api_service.dart';
import 'lecturer.dart';
class LecturerList extends StatefulWidget {
  @override
  _LecturerListState createState() => _LecturerListState();
}
class _LecturerListState extends State<LecturerList> {
  late Future<List<Lecturer>> futureLecturers;
  @override
  void initState() {
    super.initState();
    futureLecturers = ApiService().fetchLecturers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách giảng viên'),
      ),
      body: FutureBuilder<List<Lecturer>>(
        future: futureLecturers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có dữ liệu'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Lecturer lecturer = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LecturerDetail(id: lecturer.id),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,  // Màu nền trắng
                      borderRadius: BorderRadius.circular(12), // Bo góc
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ], // Bóng đổ nhẹ
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      title: Text(
                        lecturer.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Đổi font chữ
                      ),
                      subtitle: Text(
                        lecturer.email, // Hoặc lecturer.major nếu muốn
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]), // Màu cho subtitle
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}