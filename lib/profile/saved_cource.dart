import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../models/khoa_hoc.dart';
import '../providers/learning_provider.dart';
import '../utils/screen_size.dart';
import '../My_cources/cources_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SavedCourse extends StatefulWidget {
  const SavedCourse({Key? key}) : super(key: key);

  @override
  State<SavedCourse> createState() => _SavedCourseState();
}

class _SavedCourseState extends State<SavedCourse> {
  @override
  void initState() {
    super.initState();
    // Tải danh sách khóa học đã lưu khi màn hình được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LearningProvider>(context, listen: false).fetchSavedCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Consumer<LearningProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.error != null) {
                    return Center(child: Text(provider.error!));
                  }

                  if (provider.savedCourses.isEmpty) {
                    return Center(
                      child: Text(
                        'Bạn chưa lưu khóa học nào',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    );
                  }

                  return _buildCourseList(provider.savedCourses);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Image(
              image: const AssetImage("assets/back_arrow.png"),
              height: 24.h,
              width: 24.w,
            ),
          ),
          SizedBox(width: 15.w),
          Text(
            "Khóa học đã lưu",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList(List<KhoaHoc> courses) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return _buildCourseCard(course);
      },
    );
  }

  Widget _buildCourseCard(KhoaHoc course) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.h),
        boxShadow: [
          BoxShadow(
            color: const Color(0XFF23408F).withOpacity(0.14),
            offset: const Offset(-4, 5),
            blurRadius: 16,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22.h),
          onTap: () {
            // Chuyển đến trang chi tiết khóa học
            Get.to(() => CourceDetail(khoaHoc: course));
          },
          child: Padding(
            padding: EdgeInsets.all(15.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.h),
                  child: CachedNetworkImage(
                    imageUrl: course.thumbnail ?? '',
                    width: 100.w,
                    height: 100.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: const Color(0XFFE5ECFF),
                        borderRadius: BorderRadius.circular(15.h),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: const Color(0XFF23408F),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: const Color(0XFFE5ECFF),
                        borderRadius: BorderRadius.circular(15.h),
                        image: const DecorationImage(
                          image: AssetImage('assets/default_course.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              course.tenKhoaHoc,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Gilroy',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: Text('Xác nhận'),
                                  content: Text('Bạn muốn bỏ lưu khóa học này?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text('Hủy'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        final success = await Provider.of<LearningProvider>(
                                          context,
                                          listen: false
                                        ).saveCourse(course.id!);
                                        
                                        if (success) {
                                          Get.snackbar(
                                            'Thành công',
                                            'Đã bỏ lưu khóa học',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Lỗi',
                                            'Không thể bỏ lưu khóa học',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                          );
                                        }
                                      },
                                      child: Text('Đồng ý'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        course.moTa ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontFamily: 'Gilroy',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '${course.gia.toStringAsFixed(0)} VNĐ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0XFF23408F),
                          fontFamily: 'Gilroy',
                        ),
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
  }
}
