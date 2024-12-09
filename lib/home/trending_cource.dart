// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../utils/screen_size.dart';

class TrendingCource extends StatefulWidget {
  const TrendingCource({Key? key}) : super(key: key);

  @override
  State<TrendingCource> createState() => _TrendingCourceState();
}

class _TrendingCourceState extends State<TrendingCource> {
  List cource = Utils.getTrending();
  toggle(int index){
    setState(() {
      if(cource[index].buttonStatus==true){
        cource[index].buttonStatus=false;
      }
      else{
        cource[index].buttonStatus=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image(
                        image: const AssetImage("assets/back_arrow.png"),
                        height: 24.h,
                        width: 24.w,
                      )),
                  SizedBox(width: 16.w),
                  Text(
                    "Trending Course",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color(0XFF000000),
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            trending_cource_list(),
          ],
        ),
      )),
    );
  }

  Widget trending_cource_list() {
    return Expanded(
      flex: 1,
      child: GridView.count(
        physics:  BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        crossAxisCount: 2,
        crossAxisSpacing: 18.73,
        mainAxisSpacing: 20,
        childAspectRatio: 0.8,



        children: cource
            .map((index) => Container(
                  //height: 302,
                  width: 177.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0XFF23408F).withOpacity(0.14),
                            offset: const Offset(-4, 5),
                            blurRadius: 16),
                      ],
                      color: const Color(0XFFFFFFFF)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(

                          children: [
                            Container(

                              width: 190.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(index.photo!),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          const Color(0XFF23408F).withOpacity(0.14),
                                      offset: const Offset(-4, 5),
                                      blurRadius: 16),
                                ],
                              ),


                            ),
                            GestureDetector(
                              onTap: (){
                                toggle(index);
                              },
                              child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.white),
                                  child: Image(
                                    image:  AssetImage("assets/like.png"),
                                    height: 50.08.h,
                                    width: 50.08.w,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.w, right: 6.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    index.title!,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Gilroy',
                                        color: const Color(0XFF000000),

                                    ),maxLines: 1,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              index.subtitle!,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Gilroy',
                                  color:  Color(0XFF000000),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 27.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0XFFFAF4E1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              "assets/staricon.png"),
                                          height: 15.h,
                                          width: 15.w,
                                        ),
                                        Text(
                                          index.review!,
                                          style: TextStyle(
                                              color: Color(0XFFFFC403),
                                              fontFamily: 'Gilroy',
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 6.w),
                                    child: SizedBox(
                                      height: 21.h,
                                      width: 76.w,
                                      child: Row(
                                        children: [
                                          Image(
                                            image: const AssetImage(
                                                "assets/clock.png"),
                                            height: 17.h,
                                            width: 17.w,
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(
                                              index.time!,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: const Color(0XFF000000),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage(index.circleimage!),
                                  height: 30.h,
                                  width: 30.w,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  index.personname!,
                                  style: TextStyle(
                                      color: const Color(0XFF23408F),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Gilroy'),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
