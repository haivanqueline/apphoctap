// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../models/chate_data.dart';
import '../utils/screen_size.dart';
import '../utils/slider_page_data_model.dart';
import 'detail_chate.dart';

class ChateScreen extends StatefulWidget {
  const ChateScreen({Key? key}) : super(key: key);

  @override
  State<ChateScreen> createState() => _ChateScreenState();
}

class _ChateScreenState extends State<ChateScreen> {
  ChateScreenController chateScreenController =
      Get.put(ChateScreenController());
  List<Chate> chate = Utils.getChate();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0XFF23408F),
            child:  Image(
              image: AssetImage("assets/floatingaction.png"),
              height: 24.h,
              width: 24.w,
            )),
        body: GetBuilder<ChateScreenController>(
          init: ChateScreenController(),
          builder: (chateScreenController) => SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                search_text_field(),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: ListView.builder(

                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: chate.length,
                            itemBuilder: ((context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 22.w : 10.w, right: 10.w),
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(chate[index].photo!))),
                                    child:  Padding(
                                      padding:  EdgeInsets.only(
                                          top: 36.h, left: 35.h),
                                      child: Image(
                                        image:
                                            AssetImage("assets/notification.png"),
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                    ),
                                  ),
                                ))),
                      ),
                      SizedBox(height: 20.h),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: chate.length,
                          itemBuilder: ((context, index) => GestureDetector(
                            onTap: (){
                              Get.to(DetailChate(detail: chate[index],));
                            },
                            child: Padding(
                                  padding:  EdgeInsets.only(
                                      top: 10.h, bottom: 10.h, left: 20.w, right: 20.w),
                                  child: Container(
                                      height: 70.h,
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
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            //SizedBox(width: 10),

                                            //const SizedBox(width: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 10.w),
                                                Container(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              chate[index].photo!))),
                                                  child:  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 36.h, left: 35.w),
                                                    child: Image(
                                                      image: const AssetImage(
                                                          "assets/notification.png"),
                                                      height: 10.h,
                                                      width: 10.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 15.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      chate[index].full_name!,
                                                      style:  TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Gilroy'),
                                                    ),
                                                     SizedBox(height: 2.h),
                                                    Text(
                                                      chate[index].message!,
                                                      style:  TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: 'Gilroy',
                                                          color: const Color(0XFF6E758A)),
                                                    )
                                                  ],
                                                ),

                                              ],
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(right: 10.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(chate[index].time!,
                                                      style:  TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          fontFamily: 'Gilroy')),
                                                  SizedBox(height: 4.h),
                                                  Container(
                                                      height: 16.h,
                                                      width: 16.w,
                                                      decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                          BoxShape.circle,
                                                          color: Color(
                                                              0XFF23408F)),
                                                      child: Center(
                                                          child: Text(
                                                              chate[index]
                                                                  .messageCount!,
                                                              style:  TextStyle(
                                                                  fontSize: 9.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  fontFamily:
                                                                  'Gilroy',
                                                                  color: Color(
                                                                      0XFFFFFFFF)))))
                                                ],
                                              ),
                                            ),
                                          ])),
                                ),
                          ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget search_text_field() {
    return Padding(
      padding:  EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        height: 50,
        child: TextFormField(
            decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: Color(0XFF23408F), width: 1.w),
              borderRadius: BorderRadius.circular(22)),
          hintText: 'Search',
          hintStyle:  TextStyle(
              color: Color(0XFF9B9B9B),
              fontSize: 15.sp,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w400),
          prefixIcon: const Image(
            image: AssetImage('assets/search.png'),
            height: 24,
            width: 24,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22.h),
              borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
        )),
      ),
    );
  }
}
