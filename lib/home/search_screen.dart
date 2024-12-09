// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../models/design_list.dart';
import '../models/recently_added.dart';
import '../models/trending_cource.dart';
import '../utils/screen_size.dart';
import '../utils/slider_page_data_model.dart';
import 'filter_sheet.dart';
import '../providers/learning_provider.dart';
import '../models/khoa_hoc.dart';
import '../My_cources/cources_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedSortBy;
  double? _minPrice;
  double? _maxPrice;

  @override
  void initState() {
    super.initState();
    // Reset kết quả tìm kiếm khi vào màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LearningProvider>().clearSearchResults();
    });
  }

  void _performSearch() {
    final provider = context.read<LearningProvider>();
    provider.searchCourses(
      keyword: _searchController.text,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      sortBy: _selectedSortBy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<LearningProvider>(
        builder: (context, provider, child) => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Back button and title
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 20.w,
                              color: Color(0XFF23408F),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Tìm kiếm khóa học',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF23408F),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    
                    // Search field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (value) => _performSearch(),
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm khóa học...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14.sp,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0XFF23408F),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => FilterSheet(
                                  onApplyFilter: (minPrice, maxPrice, sortBy) {
                                    setState(() {
                                      _minPrice = minPrice;
                                      _maxPrice = maxPrice;
                                      _selectedSortBy = sortBy;
                                    });
                                    _performSearch();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              child: Icon(
                                Icons.tune,
                                color: Color(0XFF23408F),
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 10.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Results
              Expanded(
                child: provider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0XFF23408F),
                        ),
                      )
                    : provider.error != null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 48.w,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  provider.error!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : provider.searchResults.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 48.w,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      'Không tìm thấy khóa học nào',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.all(20.w),
                                itemCount: provider.searchResults.length,
                                itemBuilder: (context, index) {
                                  final course = provider.searchResults[index];
                                  return CourseCard(
                                    course: course,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CourceDetail(
                                            khoaHoc: course,
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
}

// Widget hiển thị card khóa học
class CourseCard extends StatelessWidget {
  final KhoaHoc course;
  final VoidCallback onTap;

  const CourseCard({
    Key? key,
    required this.course,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF23408F).withOpacity(0.08),
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: course.thumbnail != null
                  ? Image.network(
                      course.thumbnail!,
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180.h,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          size: 48.w,
                          color: Colors.grey[400],
                        ),
                      ),
                    )
                  : Container(
                      height: 180.h,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 48.w,
                        color: Colors.grey[400],
                      ),
                    ),
            ),
            
            // Course Info
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.tenKhoaHoc,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (course.moTa != null && course.moTa!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      course.moTa!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${course.gia.toStringAsFixed(0)} VNĐ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF23408F),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0XFF23408F).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Xem chi tiết',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF23408F),
                          ),
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
    );
  }
}
