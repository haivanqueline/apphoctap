import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/home/recent_added_cource_detail.dart';

import 'package:learn_megnagmet/models/recently_added.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../utils/screen_size.dart';


class RecentlyAdded extends StatefulWidget {
  const RecentlyAdded({Key? key}) : super(key: key);

  @override
  State<RecentlyAdded> createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded> {

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }
  List<Recent> recentcource = [];


  @override
  void initState() {
    recentcource = Utils.getRecentAdded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: Column(
        children: [
           SizedBox(height: 60.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              children: [
                 GestureDetector(
                   onTap: (){
                     Get.back();
                   },
                   child: Image(
                    image: AssetImage("assets/back_arrow.png"),
                    height: 24.h,
                    width: 24.w,
                ),
                 ),
                SizedBox(width: 16.w),
                 Text(
                  "Recently Added Course",
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0XFF000000),
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          recently_added_cources_list(),
        ],
      ),
    );
  }

  Widget recently_added_cources_list() {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: recentcource.length,
          itemBuilder: (BuildContext, index) {
            return GestureDetector(
              onTap: (){
                Get.to(RecentCourceDetail(corcedetail: recentcource[index],));
              },
              child: Padding(
                padding:  EdgeInsets.only(left: 20.w,right: 20.w,top:index==0?0.h: 10.h,bottom: 10.h),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.h),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0XFF23408F).withOpacity(0.14),
                            offset: const Offset(-4, 5),
                            blurRadius: 16.h),
                      ],
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(0.h),
                            child: Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.h),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0XFF23408F)
                                            .withOpacity(0.14),
                                        offset: const Offset(-4, 5),
                                        blurRadius: 16.h),
                                  ],
                                  color: Colors.white),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 210.h,
                                    width: double.infinity.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.h),
                                        color: Colors.white),
                                    child: Image(
                                      image:
                                          AssetImage(recentcource[index].photo!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                         EdgeInsets.only(left: 10.w, top: 10.h),
                                    child: Container(
                                        height: 33.h,
                                        width: 32.w,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: IconButton(splashRadius: 10.h,
                                            onPressed: () {

                                            },
                                            icon:  const Center(
                                              child:  Image(image: AssetImage("assets/saveicon.png"))
                                            ))),
                                  ),
                                  Padding(
                                    padding:
                                         EdgeInsets.only(left: 55.w, top: 10.h),
                                    child: Container(
                                        height: 33.h,
                                        width: 32.w,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: Center(
                                          child: IconButton(
                                              onPressed: () {
                                                share();
                                              },
                                              icon: Image(image: AssetImage("assets/shareicon.png")),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(height: 10.h),
                      Padding(
                        padding:  EdgeInsets.only(left: 10.42.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              children: [
                                Container(
                                  height: 27.h,
                                  width: 59.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.h),
                                    color: const Color(0XFFFAF4E1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                       Image(image:const AssetImage("assets/staricon.png"),height: 17.h,width: 17.w),
                                      Text(
                                        recentcource[index].review!,
                                        style:  TextStyle(
                                            color: Color(0XFFFFC403),
                                            fontFamily: 'Gilroy',
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 23.h,
                                  width: 91.w,
                                  //color: Colors.red,
                                  child: Row(
                                    children: [
                                      Image(image: const AssetImage("assets/clock.png"),height: 17.h,width: 17.w),
                                       SizedBox(width: 4.w),
                                      Text(
                                        recentcource[index].time!,
                                        style:  TextStyle(
                                            fontSize: 15.sp,
                                            color: const Color(0XFF000000),
                                            fontFamily: 'Gilroy'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                       SizedBox(height: 11.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: 68.w),
                              child: Text(
                                recentcource[index].title!,
                                style:  TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp,
                                    fontFamily: 'Gilroy',
                                    color: Color(0XFF000000)),
                              ),
                            ),
                             SizedBox(height: 11.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          recentcource[index].circleimage!),
                                      height: 40.h,
                                      width: 40.w,
                                    ),
                                     SizedBox(width: 10.w),
                                    Text(
                                      recentcource[index].personname!,
                                      style:  TextStyle(
                                          color: Color(0XFF23408F),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gilroy'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: 74.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.h),
                                          color:const  Color(0XFFE5ECFF)),
                                      child: Center(
                                          child: Text(
                                        recentcource[index].price!,
                                        style:  TextStyle(
                                            color: const Color(0XFF23408F),
                                            fontFamily: 'Gilroy',
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.w700),
                                      )),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                       SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
