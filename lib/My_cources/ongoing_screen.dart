import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utils/screen_size.dart';
import 'cources_details.dart';
import 'package:learn_megnagmet/models/my_cource.dart';
import 'package:learn_megnagmet/constant/api_service.dart';

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  final ApiService apiService = ApiService(); // Khởi tạo ApiService
  late Future<List<OngoingCources>> _ongoingCoursesFuture; // Dữ liệu từ API

  @override
  void initState() {
    super.initState();
    _ongoingCoursesFuture = apiService.fetchOngoingCourses(); // Lấy dữ liệu từ API
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: FutureBuilder<List<OngoingCources>>(
        future: _ongoingCoursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No ongoing courses found."));
          } else {
            final ongoingCourses = snapshot.data!;
            return ListView.builder(
              itemCount: ongoingCourses.length,
              itemBuilder: (context, index) {
                final course = ongoingCourses[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.h, horizontal: 15.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourceDetail(
                              corcedetail: course), // Truyền dữ liệu chi tiết
                        ),
                      );
                    },
                    child: Container(
                      height: 124,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0XFF23408F).withOpacity(0.14),
                            offset: const Offset(-4, 5),
                            blurRadius: 16,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            course.courceImage != null
                                ? Image.network(
                              course.courceImage!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                                : const Icon(Icons.image, size: 100),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    course.courceName ?? "No Course Name",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Gilroy',
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "8 Lessons to go",
                                    style: TextStyle(
                                        color: Color(0XFF292929)),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          lineHeight: 6.0,
                                          percent: 0.5, // Giá trị giả định
                                          trailing: Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: Text(
                                              "50%",
                                              style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          backgroundColor:
                                          const Color(0XFFDEDEDE),
                                          progressColor:
                                          const Color(0XFF23408F),
                                          barRadius:
                                          const Radius.circular(22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
