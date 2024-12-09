import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Sử dụng Get để điều hướng
import 'package:learn_megnagmet/constant/api_service.dart';
import 'package:learn_megnagmet/models/my_cource.dart';
import 'package:learn_megnagmet/My_cources/cources_details.dart'; // Import màn hình chi tiết khóa học
import 'package:learn_megnagmet/home/search_screen.dart'; // Import màn hình tìm kiếm
import 'package:shared_preferences/shared_preferences.dart'; // Thêm SharedPreferences

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<OngoingCources> allCourses = []; // Danh sách tất cả khóa học

  @override
  void initState() {
    super.initState();
    fetchAllCourses(); // Lấy dữ liệu khóa học khi màn hình khởi tạo
  }

  // Hàm gọi API lấy tất cả khóa học
  void fetchAllCourses() async {
    try {
      var results = await apiService.fetchOngoingCourses();
      setState(() {
        allCourses = results; // Lưu danh sách khóa học
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  // Hàm lưu khóa học vào SharedPreferences
  Future<void> saveCourse(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCourses = prefs.getStringList('saved_courses') ?? [];
    if (!savedCourses.contains(courseId)) {
      savedCourses.add(courseId); // Lưu ID khóa học nếu chưa có
      prefs.setStringList('saved_courses', savedCourses);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
        automaticallyImplyLeading: false, // Loại bỏ nút quay lại
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm (nút dẫn đến màn hình tìm kiếm)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onTap: () {
                // Chuyển hướng sang màn hình tìm kiếm
                Get.to(() => SearchScreen(allCourses: allCourses));
              },
              readOnly: true, // Chỉ bấm được, không nhập liệu
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0XFF23408F), // Màu sắc của đường viền khi focus
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(22), // Đường viền bo tròn
                ),
                hintText: 'Search', // Văn bản gợi ý khi chưa nhập liệu
                hintStyle: TextStyle(
                  color: Color(0XFF9B9B9B), // Màu sắc của văn bản gợi ý
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(
                  Icons.search, // Biểu tượng tìm kiếm
                  color: Color(0XFF23408F), // Màu sắc của biểu tượng tìm kiếm
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    // Xử lý sự kiện khi người dùng bấm vào biểu tượng lọc
                  },
                  child: Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/filico.png'), // Thay thế bằng biểu tượng bạn muốn
                      ),
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22), // Bo tròn các góc
                ),
              ),
            ),
          ),
          // Danh sách khóa học dạng lưới
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cột
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 3 / 4, // Tỉ lệ chiều ngang và chiều cao
              ),
              itemCount: allCourses.length,
              itemBuilder: (context, index) {
                final course = allCourses[index];
                return GestureDetector(
                  onTap: () async {
  final course = allCourses[index];
  await saveCourse(course.courceName); // Lưu tên khóa học thay vì id
  Get.to(() => CourceDetail(corcedetail: course)); // Chuyển đến chi tiết khóa học
},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Ảnh khóa học
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8.0),
                            ),
                            child: Image.network(
                              course.courceImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Tên khóa học
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            course.courceName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
