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
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<Lecturer>(
        future: ApiService().fetchLecturerById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Không tìm thấy giảng viên'));
          } else {
            Lecturer lecturer = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo[50]!, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header với Avatar
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150'), // Thay bằng URL thật nếu có
                              backgroundColor: Colors.grey[200],
                            ),
                            SizedBox(height: 16),
                            Text(
                              lecturer.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo[900],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              lecturer.email,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 30, thickness: 1),
                      // Thông tin chi tiết
                      InfoRow(
                        icon: Icons.badge,
                        label: 'Mã GV:',
                        value: lecturer.magv ?? 'Không có dữ liệu',
                      ),
                      InfoRow(
                        icon: Icons.phone,
                        label: 'Số điện thoại:',
                        value: lecturer.phoneNumber ?? 'Không có dữ liệu',
                      ),
                      InfoRow(
                        icon: Icons.school,
                        label: 'Khoa:',
                        value: lecturer.faculty ?? 'Không có dữ liệu',
                      ),
                      InfoRow(
                        icon: Icons.work,
                        label: 'Chuyên ngành:',
                        value: lecturer.major ?? 'Không có dữ liệu',
                      ),
                      InfoRow(
                        icon: Icons.military_tech,
                        label: 'Học vị:',
                        value: lecturer.degree ?? 'Không có dữ liệu',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.indigo,
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo[800],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
