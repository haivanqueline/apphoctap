import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../providers/learning_provider.dart';
import 'cources_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        final ongoingCourses = provider.myCourses
            .where((course) => course.trangThai == 'active')
            .toList();

        if (ongoingCourses.isEmpty) {
          return const Center(
            child: Text('Không có khóa học đang học'),
          );
        }

        return ListView.builder(
          itemCount: ongoingCourses.length,
          itemBuilder: (context, index) {
            final course = ongoingCourses[index];
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
                        _buildThumbnail(course.thumbnail),
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
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.h),
                              LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                lineHeight: 6.h,
                                backgroundColor: const Color(0XFFDEDEDE),
                                progressColor: const Color(0XFF23408F),
                                percent: 0.0,
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

  Widget _buildThumbnail(String? thumbnailUrl) {
    if (thumbnailUrl == null || thumbnailUrl.isEmpty) {
      return _buildPlaceholder();
    }


    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: thumbnailUrl,
        height: 100.h,
        width: 100.w,
        fit: BoxFit.cover,
        httpHeaders: {
          'Accept': 'image/jpeg,image/png,image/jpg',
        },
        placeholder: (context, url) => Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF23408F)),
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          return Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.grey[400],
                  size: 30,
                ),
                SizedBox(height: 5.h),
                Text(
                  'Lỗi tải ảnh',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
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
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.grey[400],
            size: 30,
          ),
          SizedBox(height: 5.h),
          Text(
            'Lỗi tải ảnh',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget(ImageChunkEvent loadingProgress) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Đang tải ảnh...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.h),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 6.h,
            backgroundColor: const Color(0XFFDEDEDE),
            progressColor: const Color(0XFF23408F),
            percent: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : 0.0,
            barRadius: const Radius.circular(22),
          ),
        ],
      ),
    );
  }
}
