

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';

import '../utils/screen_size.dart';
import 'completed_screen.dart';
import 'ongoing_screen.dart';

class OngoingCompletedScreen extends StatefulWidget {
  const OngoingCompletedScreen({Key? key}) : super(key: key);

  @override
  State<OngoingCompletedScreen> createState() => _OngoingCompletedScreenState();
}

class _OngoingCompletedScreenState extends State<OngoingCompletedScreen> {

  OngoingCompletedController ongoingCompletedController =
      Get.put(OngoingCompletedController());
  PageController pageController = PageController();
  List courcesClass = [OngoingScreen(), CompletedScreen()];
  int initialValue = 1;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        body: WillPopScope(
          onWillPop: (){
            return Future.value(false);
          },
          child: GetBuilder<OngoingCompletedController>(
      init: OngoingCompletedController(),
      builder: (controller) => Column(
          children: [
             SizedBox(height: 73.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                      child:  Image(
                        image: const AssetImage("assets/back_arrow.png"),
                        height: 24.h,
                        width: 24.w,
                      )),
                   SizedBox(width: 16.w),
                   Text(
                    "My Courses",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
                  ),
                ],
              ),
            ),
             SizedBox(height: 20.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 54,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.h),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0XFF23408F).withOpacity(0.14),
                          offset: const Offset(-4, 5),
                          blurRadius: 16.h),
                    ],
                    color: Colors.white),
                child: Padding(
                  padding:  EdgeInsets.only(left: 8.w, right: 8.w),
                  child: TabBar(
                    unselectedLabelColor: Color(0XFF6E758A),
                    padding:
                     EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
                    labelStyle:  TextStyle(
                        color: Color(0XFF23408F),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy'),
                    labelColor: const Color(0XFF23408F),
                    unselectedLabelStyle:  TextStyle(
                        color: Color(0XFF23408F),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy'),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: ShapeDecoration(

                        color: const Color(0XFFE5ECFF),
                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(22.h),)),
                    controller: ongoingCompletedController.tabController,
                    tabs: const [
                      Tab(
                        text: "Ongoing ",
                      ),
                      Tab(
                        text: "Completed",
                      ),

                    ],
                    onTap: (value) {
                      ongoingCompletedController.pController.animateToPage(value,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),

                ),
              ),
            ),
SizedBox(height: 20.h),
            Expanded(
              child: PageView.builder(

                controller:ongoingCompletedController.pController,
                onPageChanged: (value){
                  ongoingCompletedController.tabController.animateTo(value,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },

                itemCount: courcesClass.length,
                itemBuilder: (context, index) {
                  return courcesClass[index];
                },
              ),
            ),
          ],
      ),
    ),
        ));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
