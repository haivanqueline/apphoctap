import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/models/my_cource.dart';
import 'package:learn_megnagmet/constant/api_service.dart';
import 'package:learn_megnagmet/models/ongoing_cource_detail.dart'; // Đảm bảo đường dẫn chính xác

import 'package:learn_megnagmet/constant/cource_details.dart';
import 'package:learn_megnagmet/utils/screen_size.dart';
import 'lesson_play.dart';
import 'package:learn_megnagmet/profile/my_certification.dart'; // Import MyCertification screen

class CourceDetail extends StatefulWidget {
  const CourceDetail({Key? key, required this.corcedetail}) : super(key: key);
  final OngoingCources corcedetail;

  @override
  State<CourceDetail> createState() => _CourceDetailState();
}

class _CourceDetailState extends State<CourceDetail> {
  late Future<List<CourceDetails>> courceDetail;

  @override
  void initState() {
    super.initState();
    courceDetail = CourceDetailsService().fetchLessons(); // Load lessons from API
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);

    return Scaffold(
      body: FutureBuilder<List<CourceDetails>>(
        future: courceDetail,
        builder: (context, snapshot) {
          // Trạng thái đang tải
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // Trạng thái lỗi
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Trường hợp không có dữ liệu
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No lessons available.'));
          }
          // Trường hợp có dữ liệu
          else {
            final courceDetails = snapshot.data!.where((element) => element.courceID == widget.corcedetail.id).toList();

            return Column(
              children: [
                SizedBox(height: 64.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset("assets/back_arrow.png", height: 24.h, width: 24.w),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        "${widget.corcedetail.courceName}",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: courceDetails.length,
                    itemBuilder: (context, index) {
                      final lesson = courceDetails[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0XFF23408F).withOpacity(0.14),
                                    offset: Offset(-4, 5),
                                    blurRadius: 16,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Hiển thị số bài học theo thứ tự (1, 2, 3,...)
                                  Container(
                                    height: 55.h,
                                    width: 33.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22.h),
                                      color: Color(0XFFE5ECFF),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}", // Hiển thị số thứ tự bài học
                                        style: TextStyle(
                                          color: Color(0XFF23408F),
                                          fontSize: 15.sp,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Hiển thị tên bài học và thời gian
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 18.h),
                                      Text(
                                        lesson.lessonName!,
                                        style: TextStyle(
                                          color: Color(0XFF000000),
                                          fontSize: 14.sp,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        lesson.time!,
                                        style: TextStyle(
                                          color: Color(0XFF6E758A),
                                          fontSize: 14.sp,
                                          fontFamily: 'Gilroy',
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Hiển thị biểu tượng phát video
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VidioPlay(
                                                lessonplay: lesson,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          lesson.playIconImage ?? "assets/lessonplay.png",
                                          height: 26.h,
                                          width: 26.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
                    child: Container(
                      height: 56.h,
                      width: 374.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        color: Color(0XFF23408F),
                      ),
                      child: Center(
                        child: Text(
                          "Continue Course",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Nút Hoàn thành khóa học
                GestureDetector(
                  onTap: () {
                    // Chuyển sang màn hình chứng chỉ
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCertification(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
                    child: Container(
                      height: 56.h,
                      width: 374.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        color: Color(0XFF23408F),
                      ),
                      child: Center(
                        child: Text(
                          "Complete Course",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
