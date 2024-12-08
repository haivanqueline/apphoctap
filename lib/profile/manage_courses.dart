import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../providers/learning_provider.dart';
import '../utils/screen_size.dart';

class ManageCourses extends StatefulWidget {
  const ManageCourses({Key? key}) : super(key: key);

  @override
  State<ManageCourses> createState() => _ManageCoursesState();
}

class _ManageCoursesState extends State<ManageCourses> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LearningProvider>(context, listen: false).fetchMyCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _buildHeader(),
              SizedBox(height: 20.h),
              Expanded(
                child: Consumer<LearningProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (provider.myCourses.isEmpty) {
                      return Center(
                        child: Text(
                          'Không có khóa học nào',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.myCourses.length,
                      itemBuilder: (context, index) {
                        final course = provider.myCourses[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.h),
                            title: Text(
                              course.tenKhoaHoc ?? '',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.h),
                                Text(
                                  course.moTa ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Gilroy',
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () => _showLessons(course.id!),
                                      icon: Icon(Icons.list),
                                      label: Text('Bài học'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Color(0xFF23408F),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          _showDeleteDialog(course.id!),
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 24.h),
        ),
        SizedBox(width: 15.w),
        Text(
          "Quản lý khóa học",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Gilroy',
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(int khoaHocId) {
    Get.dialog(
      AlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn xóa khóa học này?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              try {
                final success =
                    await Provider.of<LearningProvider>(context, listen: false)
                        .deleteCourse(khoaHocId);

                if (success) {
                  Get.snackbar(
                    'Thành công',
                    'Đã xóa khóa học',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    'Lỗi',
                    'Bạn không có quyền xóa khóa học này',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              } catch (e) {
                Get.snackbar(
                  'Lỗi',
                  'Đã xảy ra lỗi khi xóa khóa học. Vui lòng thử lại sau.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showLessons(int khoaHocId) {
    Get.dialog(
      AlertDialog(
        title: Text('Danh sách bài học'),
        content: Consumer<LearningProvider>(
          builder: (context, provider, child) {
            if (provider.isLoadingLessons) {
              return Center(child: CircularProgressIndicator());
            }

            final lessons = provider.lessons
                .where((lesson) => lesson.idKhoahoc == khoaHocId)
                .toList();

            if (lessons.isEmpty) {
              return Text('Không có bài học nào');
            }

            return SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  return ListTile(
                    title: Text(lesson.tenBaiHoc ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteLessonDialog(
                        lesson.id!,
                        khoaHocId,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void _showDeleteLessonDialog(int baiHocId, int khoaHocId) {
    Get.dialog(
      AlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn xóa bài học này?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              final success =
                  await Provider.of<LearningProvider>(context, listen: false)
                      .deleteLesson(baiHocId, khoaHocId);

              if (success) {
                Get.snackbar(
                  'Thành công',
                  'Đã xóa bài học',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              }
            },
            child: Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
