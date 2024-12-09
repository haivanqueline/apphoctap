import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Sử dụng Get để điều hướng
import 'package:learn_megnagmet/models/my_cource.dart';
import 'package:learn_megnagmet/My_cources/cources_details.dart'; // Import màn hình chi tiết khóa học

class SearchScreen extends StatefulWidget {
  final List<OngoingCources> allCourses; // Nhận danh sách từ HomeScreen

  const SearchScreen({Key? key, required this.allCourses}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<OngoingCources> filteredCourses = []; // Danh sách khóa học đã lọc
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCourses = widget.allCourses; // Hiển thị tất cả khóa học ban đầu
  }

  // Hàm lọc khóa học
  void filterCourses(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCourses = widget.allCourses; // Hiển thị lại tất cả khóa học
      });
      return;
    }

    setState(() {
      filteredCourses = widget.allCourses
          .where((course) =>
              course.courceName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Courses"),
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: filterCourses, // Lọc danh sách khi nhập từ khóa
            ),
          ),

          // Danh sách kết quả tìm kiếm
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                return GestureDetector(
                  onTap: () {
                    // Điều hướng sang màn hình chi tiết khóa học
                    Get.to(() => CourceDetail(corcedetail: course));
                  },
                  child: ListTile(
                    leading: Image.network(
                      course.courceImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(course.courceName),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
