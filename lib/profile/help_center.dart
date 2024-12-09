import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../utils/screen_size.dart';
import 'ContactUs.dart';
import 'faq_screen_page.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  PageController pageController = PageController();
  int initialValue=1;
  HelpCenterController helpCenterController = Get.put(HelpCenterController());
  List helpCenter=[FAQScreen(),ContactUsScreen()];
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        body: GetBuilder<HelpCenterController>(
          init: HelpCenterController(),
          builder: (controller) => Column(
            children: [
               SizedBox(height: 70.h),
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.h),
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child:  Image(image: AssetImage("assets/back_arrow.png"),height: 24.h,width: 24.h,)),
                  ),
                   SizedBox(width: 15.h),
                   Text(
                    "Help Center",
                    style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Gilroy', fontSize: 24.sp),
                  ),
                ],
              ),
               SizedBox(height: 20.h),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 54.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0XFF23408F).withOpacity(0.14),
                            offset: const Offset(-4, 5),
                            blurRadius: 16.h),
                      ],
                      color: Colors.white),
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
                        color:const  Color(0XFF23408F),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy'),

                    indicator: ShapeDecoration(

                        color: const Color(0XFFE5ECFF),
                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(22.h))),
                    controller: helpCenterController.tabController,
                    indicatorSize: TabBarIndicatorSize.tab,


                    tabs: const [
                      Tab(
                        text: "FAQ ",
                      ),
                      Tab(
                        text: "Contact Us",
                      ),

                    ],
                    onTap: (value) {
                      helpCenterController.pController.animateToPage(value,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },

                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: helpCenterController.pController,
                  onPageChanged: (value) {
                    helpCenterController.tabController.animateTo(value,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                 // controller: helpCenterController.tabController,
                  itemCount: helpCenter.length,
                  itemBuilder: (context, index) {
                    return helpCenter[index];
                  },
                ),
              ),
            ],
          ),
        ));
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
