import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../providers/learning_provider.dart';
import 'cources_details.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        final completedCourses = provider.myCourses
            .where((course) => course.trangThai == 'completed')
            .toList();

        if (completedCourses.isEmpty) {
          return const Center(
            child: Text('Chưa có khóa học nào hoàn thành'),
          );
        }
        if (provider.error != null) {
          return Center(child: Text(provider.error!));
        }

        return ListView.builder(
          itemCount: completedCourses.length,
          itemBuilder: (context, index) {
            final course = completedCourses[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourceDetail(khoaHoc: course),
                    ),
                  );
                },
                child: Container(
                  height: 124.h,
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
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        course.thumbnail != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  course.thumbnail!,
                                  height: 100.h,
                                  width: 100.w,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 100.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey[400],
                                        size: 40,
                                      ),
                                    );
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 100.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.image,
                                  color: Colors.grey[400],
                                  size: 40,
                                ),
                              ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                course.tenKhoaHoc,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Gilroy',
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.h),
            
                              SizedBox(height: 15.h),
                              LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                lineHeight: 6.h,
                                percent: 1.0,
                                trailing: Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: Text(
                                    "100%",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                backgroundColor: const Color(0XFFDEDEDE),
                                progressColor: const Color(0XFF23408F),
                                barRadius: const Radius.circular(22),
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
      },
    );
  }
}
