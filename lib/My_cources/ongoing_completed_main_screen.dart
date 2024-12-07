// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/learning_provider.dart';
import 'completed_screen.dart';
import 'ongoing_screen.dart';

class OngoingCompletedScreen extends StatefulWidget {
  const OngoingCompletedScreen({Key? key}) : super(key: key);

  @override
  State<OngoingCompletedScreen> createState() => _OngoingCompletedScreenState();
}

class _OngoingCompletedScreenState extends State<OngoingCompletedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      context.read<LearningProvider>().fetchMyCourses();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0XFF23408F),
            ),
          );
        }

        if (provider.error != null) {
          return Center(
            child: Text(
              'Lỗi: ${provider.error}',
              style: TextStyle(fontSize: 16.sp),
            ),
          );
        }

        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: 73.h),
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image(
                        image: const AssetImage("assets/back_arrow.png"),
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "My Courses",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              // Tab Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 54,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.h),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0XFF23408F).withOpacity(0.14),
                        offset: const Offset(-4, 5),
                        blurRadius: 16.h,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: TabBar(
                      unselectedLabelColor: const Color(0XFF6E758A),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
                      labelStyle: TextStyle(
                        color: const Color(0XFF23408F),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy',
                      ),
                      labelColor: const Color(0XFF23408F),
                      unselectedLabelStyle: TextStyle(
                        color: const Color(0XFF23408F),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy',
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: ShapeDecoration(
                        color: const Color(0XFFE5ECFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.h),
                        ),
                      ),
                      controller: _tabController,
                      tabs: const [
                        Tab(text: "Ongoing"),
                        Tab(text: "Completed"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Tab View với loading indicator
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    OngoingScreen(),
                    CompletedScreen(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
