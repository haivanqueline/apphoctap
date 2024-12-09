import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../models/lesson.dart';
import '../utils/screen_size.dart';

class Lesson extends StatefulWidget {
  const Lesson({Key? key}) : super(key: key);

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  List<LessonList> lessonLists = Utils.getLesson();

  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(
        init: HomeController(),
        builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: lessonLists.length,
                      itemBuilder: (BuildContext, index) {
                        return Padding(
                          padding:  EdgeInsets.only(top:index==0?0.h: 8.h,bottom: 8.h,left: 15.w,right: 15.w),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.h),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0XFF23408F).withOpacity(0.14),
                                      offset: const Offset(-4, 5),
                                      blurRadius: 16),
                                ],
                               ),
                            child: ExpansionTileCard(
                              trailing:Padding(
                                padding:  EdgeInsets.only(right: 20.w),
                                child: Image.asset("assets/down.png",height: 24.h,width: 24.w),
                              ),
                              animateTrailing: true,



                              contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                              borderRadius: BorderRadius.circular(22.h),
                              leading: Image.asset(
                                lessonLists[index].photo!,
                                height: 66.h,
                                width: 66.w,
                              ),

                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lessonLists[index].title!,
                                    style:  TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0XFF000000),
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.bold),
                                  ),
                                   SizedBox(height: 4.h),
                                  Container(
                                    height: 20.h,
                                    width: 63.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22.h),
                                        color: const Color(0XFFE5ECFF)),
                                    child: Center(
                                        child: Text(
                                      lessonLists[index].buttonName!,
                                      style:  TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0XFF23408F)),
                                    )),
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                 Divider(
                                  thickness: 1.0,
                                  height: 1.0.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding:  EdgeInsets.symmetric(
                                        horizontal: 16.0.w,
                                        vertical: 8.0.h
                                      ),
                                      child: lesson_detail(index),),
                                )
                              ],
                            ),
                          ),
                        );
                      }),

                ],
              ),
            ));
  }



  Widget lesson_detail(int index) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Image.asset(
                    lessonLists[index]
                        .detailicon1!,
                    height: 20.h,
                    width: 20.w),
                 SizedBox(width: 10.w),
                Flexible(
                    child: Text(
                      lessonLists[index]
                          .detail1st!,
                      style:  TextStyle(
                          fontSize: 14.sp,
                          color:
                          Color(0XFF000000)),
                    )),
                 SizedBox(width: 10.w),
                Text(
                  "${lessonLists[index].detail1stscore}",
                  style:  TextStyle(
                      fontSize: 14.sp,
                      color:
                      Color(0XFF23408F)),
                )
              ],
            ),
             SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Image.asset(
                    lessonLists[index]
                        .detailicon2!,
                    height: 20.h,
                    width: 20.w),
                 SizedBox(width: 10.w),
                Flexible(
                    child: Text(
                        lessonLists[index]
                            .detail2nd!)),
                 SizedBox(width: 120.w),
                Text(
                    "${lessonLists[index].detail2ndscore}")
              ],
            ),
             SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                    lessonLists[index]
                        .detailicon3!,
                    height: 20.h,
                    width: 20.w),
                 SizedBox(width: 10.w),
                Flexible(
                    child: Text(
                        lessonLists[index]
                            .detail3rd!)),
                 SizedBox(width: 120.w),
                Text(
                    "${lessonLists[index].detail3rdscore}")
              ],
            ),
             SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                    lessonLists[index]
                        .detailicon4!,
                    height: 20.h,
                    width: 20.w),
                 SizedBox(width: 10.w),
                Flexible(
                    child: Text(
                        lessonLists[index]
                            .detail4th!)),
                 SizedBox(width: 110.w),
                Text(
                    "${lessonLists[index].detail4thscore}")
              ],
            ),
          ],
        )
      ],
    );
  }
}
