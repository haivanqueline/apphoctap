

// ignore_for_file: deprecated_member_use

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';
import 'package:learn_megnagmet/cources/lessons_screen.dart';
import 'package:learn_megnagmet/cources/overview_page.dart';
import 'package:learn_megnagmet/cources/review_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import '../models/trending_cource.dart';
import '../utils/screen_size.dart';
import '../widget/button.dart';
import 'choose_plane_screen.dart';

class MyCources extends StatefulWidget {
  const MyCources({Key? key,required this.trende}) : super(key: key);
  final Trending trende;


  @override
  State<MyCources> createState() => _MyCourcesState();
}

class _MyCourcesState extends State<MyCources> {
  CourceController courceController = Get.put(CourceController());
  PageController pageController = PageController();
  int initialvalue = 0;



  late FlickManager flickManager;
  bool currentbuttonpos = false;
  List pageclass = [
    Overview(),
    Lesson(),
    Review(),
  ];


  @override
  void initState() {

    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
      autoPlay: false,

    );
  }

  @override
  void dispose() {
    flickManager.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: GetBuilder<CourceController>(
          init: CourceController(),
          builder: (CourceController) => SafeArea(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 20.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child:  Image(
                            image: const AssetImage("assets/back_arrow.png"),
                            height: 24.h,
                            width: 24.w,
                          )),
                       SizedBox(width: 15.w),
                       Text(
                        "Courses",
                        style: TextStyle(fontFamily: 'Gilroy',fontWeight: FontWeight.w700, fontSize: 24.sp),
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 20.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  child: Container(
                    padding: EdgeInsets.all(12.h),

                    decoration: BoxDecoration(
                      color:Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0XFF23408F).withOpacity(0.1),
                            blurRadius: 16,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(22.h),
                        ),
                    child: Container(
                      height: 195.h,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h)),
                        child: ClipRRect(borderRadius: BorderRadius.circular(22),child: FlickVideoPlayer(flickManager: flickManager))),
                  ),
                ),
                 SizedBox(height: 12.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  child: Container(
                    height: 54.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0XFF23408F).withOpacity(0.20),
                            blurRadius: 16,
                          ),
                        ],
                        color: const Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(22)),
                    child: TabBar(
                      unselectedLabelColor: Color(0XFF6E758A),
                      padding:
                           EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      labelStyle:  TextStyle(
                          color: const Color(0XFF23408F),
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          fontFamily: 'Gilroy'),
                      labelColor: const Color(0XFF23408F),
                      unselectedLabelStyle:  TextStyle(
                          color: const Color(0XFF23408F),
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          fontFamily: 'Gilroy'),
                      indicator: ShapeDecoration(
                          color: const Color(0XFFE5ECFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.h))),
                      controller: courceController.tabController,
                      tabs: const [
                        Tab(
                          text: "Overview ",
                        ),
                        Tab(
                          text: "Lessons",
                        ),
                        Tab(
                          text: "Reviews",
                        ),
                      ],
                      onTap: (value) {
                        courceController.pController.animateToPage(value,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                Expanded(
                  child: PageView.builder(
                    controller: courceController.pController,
                    onPageChanged: (value) {
                      courceController.tabController.animateTo(value,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    itemCount: pageclass.length,
                    itemBuilder: (context, index) {
                      return pageclass[index];
                    },
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom: 30.h),
                  child: CustomButton(
                    onTap: () {
                      Get.to(const ChoosePlane());
                    },
                    buttonText: 'Enroll Now',
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
