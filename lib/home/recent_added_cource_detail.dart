// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/models/recently_added.dart';

import '../My_cources/lesson_play.dart';
import '../utils/screen_size.dart';
import '../utils/slider_page_data_model.dart';

class RecentCourceDetail extends StatefulWidget {
  const RecentCourceDetail({Key? key,required this.corcedetail}) : super(key: key);
  final Recent corcedetail;

  @override
  State<RecentCourceDetail> createState() => _RecentCourceDetailState();
}

class _RecentCourceDetailState extends State<RecentCourceDetail> {
  List cource_detail = Utils.getCourceDetail();
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(child: Column(
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
                        image: AssetImage("assets/back_arrow.png"),
                        height: 24.h,
                        width: 24.w,
                      )),
                   SizedBox(width: 15.w),
                  Flexible(
                    child: Text(
                      "${widget.corcedetail.title}",
                      style:  TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 24.sp,fontFamily: 'Gilroy'),overflow: TextOverflow.ellipsis
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                  itemCount: cource_detail.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.only(
                          left: 20.w, right: 20.w, top: index==0?0.h:8.h, bottom: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? Padding(
                            padding:  EdgeInsets.only(
                              bottom: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                 Text("Lesson 1 - Introducation",style: TextStyle(
                                    fontFamily:
                                    'Gilroy',
                                    color:
                                    Color(0XFF6E758A),
                                    fontSize: 15.sp,

                                    fontWeight: FontWeight.w700),),
                                Container(
                                    height: 23.h,
                                    width: 53.w,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          22.h),
                                      color: const Color(0XFFE5ECFF),
                                    ),
                                    child:  Center(
                                      child: Text(
                                        "30 Min",
                                        style: TextStyle(
                                            fontFamily:
                                            'Gilroy',
                                            color:
                                            Color(0XFF23408F),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ))
                              ],
                            ),
                          )
                              : const SizedBox(),
                          index==3?Padding(
                            padding:  EdgeInsets.only(
                              bottom: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                 Text("Lesson 2 - User Research",style: TextStyle(
                                    fontFamily:
                                    'Gilroy',
                                    color:
                                    Color(0XFF6E758A),
                                    fontSize: 15.sp,
                                    fontStyle:
                                    FontStyle.normal,
                                    fontWeight: FontWeight.w700),),
                                Container(
                                    height: 23.h,
                                    width: 53.w,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          22.h),
                                      color: const Color(0XFFE5ECFF),
                                    ),
                                    child:  Center(
                                      child: Text(
                                        "60 Min",
                                        style: TextStyle(
                                            fontFamily:
                                            'Gilroy',
                                            color:
                                            Color(0XFF23408F),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ))
                              ],
                            ),
                          ):const SizedBox(),

                          Container(
                            height: 80.h,
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
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height: 55.h,
                                    width: 33.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(22.h),
                                        color: const Color(0XFFE5ECFF)),
                                    child: Center(
                                      child: Text(
                                        "${cource_detail[index].lessonID}",
                                        style:  TextStyle(
                                            color: Color(0XFF23408F),
                                            fontSize: 15.sp,
                                            fontFamily: 'Gilroy',
                                            fontWeight:
                                            FontWeight.w700),
                                      ),
                                    )),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                     SizedBox(height: 18.h),
                                    Text(
                                        cource_detail[index]
                                            .lessonName!,
                                        style:  TextStyle(
                                            color: Color(0XFF000000),
                                            fontSize: 14.sp,
                                            fontFamily: 'Gilroy',
                                            fontWeight:
                                            FontWeight.bold)),
                                     SizedBox(height: 10.h),
                                    Text(cource_detail[index].time!,
                                        style:  TextStyle(
                                            color: Color(0XFF6E758A),
                                            fontSize: 14.sp,
                                            fontFamily: 'Gilroy',
                                           ))
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    index < 3
                                        ? GestureDetector(
                                      child: Image(
                                        image: AssetImage(
                                            cource_detail[index]
                                                .playIconImage!),
                                        height: 26.h,
                                        width: 26.w,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonPlay(
                                                        baiHoc:
                                                        cource_detail[
                                                        index])));
                                      },
                                    )
                                        : GestureDetector(
                                      child: Image(
                                        image: AssetImage(
                                            cource_detail[index]
                                                .lockImageImage!),
                                        height: 26.h,
                                        width: 26.w,
                                      ),
                                      onTap: () {
                                        Get.snackbar('error',
                                            'This lesson is locked');
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding:  EdgeInsets.only(bottom: 40.h, top: 15.h),
                child: Container(
                  height: 56.h,
                  width: 374.w,
                  //color: Color(0XFF23408F),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.h),
                    color: const Color(0XFF23408F),
                  ),
                  child:  Center(
                    child: Text("Continue Course",
                        style: TextStyle(
                            color: Color(0XFFFFFFFF),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Gilroy')),
                  ),
                ),
              ),
            )
          ],
        ),

        ),
      ),
    );
  }
}
