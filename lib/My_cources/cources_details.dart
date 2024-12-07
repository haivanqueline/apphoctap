import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/learning_provider.dart';
import '../models/khoa_hoc.dart';
import '../models/bai_hoc.dart';
import '../My_cources/lesson_play.dart';
class CourceDetail extends StatefulWidget {
  const CourceDetail({Key? key, required this.khoaHoc}) : super(key: key);
  final KhoaHoc khoaHoc;

  @override
  State<CourceDetail> createState() => _CourceDetailState();
}

class _CourceDetailState extends State<CourceDetail> {
  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    if (widget.khoaHoc.id != null) {
      try {
        await context.read<LearningProvider>().fetchLessonContent(widget.khoaHoc.id!);
        final lessons = context.read<LearningProvider>().lessons;
        print('Loaded lessons: ${lessons.length}');
        lessons.forEach((lesson) {
          print('Lesson name: ${lesson.tenBaiHoc}');
        });
      } catch (e) {
        print('Error loading lessons: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Không thể tải danh sách bài học: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildLessonItem(BaiHoc lesson, int index) {
    print('Building lesson item ${index + 1}:');
    print('- ID: ${lesson.id}');
    print('- Ten bai hoc: ${lesson.tenBaiHoc}');
    print('- Mo ta: ${lesson.moTa}');
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonPlay(baiHoc: lesson),
            ),
          );
        },
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0XFF23408F).withOpacity(0.14),
                offset: const Offset(-4, 5),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 16.w),
              // Số thứ tự bài học
              Container(
                height: 55.h,
                width: 33.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.r),
                  color: const Color(0XFFE5ECFF),
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: const Color(0XFF23408F),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Thông tin bài học
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lesson.tenBaiHoc.isEmpty 
                          ? 'Bài ${index + 1}'  // Fallback text
                          : lesson.tenBaiHoc,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (lesson.thoiLuong != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        "${lesson.thoiLuong} phút",
                        style: TextStyle(
                          color: const Color(0XFF6E758A),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Icon play
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Icon(
                  Icons.play_circle_outline,
                  color: const Color(0XFF23408F),
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingLessons) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.error != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.error!,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _loadLessons,
                    child: Text('Thử lại'),
                  ),
                ],
              ),
            ),
          );
        }

        final lessons = provider.lessons;
        print('Rendering ${lessons.length} lessons');

        if (lessons.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chưa có bài học nào cho khóa học này',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF23408F),
                    ),
                    child: const Text('Quay lại'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          "assets/back_arrow.png",
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Text(
                          widget.khoaHoc.tenKhoaHoc,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Danh sách bài học
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      return _buildLessonItem(lesson, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}