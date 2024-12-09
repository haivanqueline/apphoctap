// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';
import 'package:learn_megnagmet/models/choose_plane.dart';
import 'package:learn_megnagmet/cources/payment_screen.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../utils/screen_size.dart';

class ChoosePlane extends StatefulWidget {
  const ChoosePlane({Key? key}) : super(key: key);

  @override
  State<ChoosePlane> createState() => _ChoosePlaneState();
}

class _ChoosePlaneState extends State<ChoosePlane> {
  ProfilePageController profilePageController =
      Get.put(ProfilePageController());
  List<ChoicePlane> plane = Utils.getChoosePlane();
  bool select = false;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          body: GetBuilder<ProfilePageController>(
              init: ProfilePageController(),
              builder: (controller) => SafeArea(
                child: Padding(
                      padding:  EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Column(
                        children: [
                           SizedBox(height: 20.h),
                          Row(
                            children:  [
                              GestureDetector(onTap:(){

                                Get.back();
                              },child:  Image(
                                image: AssetImage("assets/back_arrow.png"),
                                height: 24.h,
                                width: 24.w,
                              )),
                               SizedBox(width: 16.w),
                               Text(
                                "Choose Your Plan",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,fontFamily: 'Gilroy', fontSize: 24.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Expanded(
                            child: ListView.builder(
                                itemCount: plane.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:  EdgeInsets.all(8.0.h),
                                    child: Container(
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
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left: 15.w,
                                            right: 15.w,
                                            top: 10.h,
                                            bottom: 15.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  plane[index].planeTime!,
                                                  style:  TextStyle(
                                                      fontSize: 20.sp,
                                                      fontFamily: 'Gilroy',
                                                      fontWeight: FontWeight.w700),
                                                ),
                                                Radio(
                                                    activeColor: Color(0XFF23408F),
                                                    value: profilePageController
                                                        .choice[index],
                                                    groupValue:
                                                        profilePageController
                                                            .select,
                                                    onChanged: (value) {
                                                      profilePageController
                                                          .onClickRadioButton(
                                                              value);
                                                      select = true;
                                                    })
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      plane[index].photo!),
                                                  height: 16.h,
                                                  width: 16.w,
                                                ),
                                                 SizedBox(width: 10.w),
                                                Text(
                                                  plane[index].planfacelity1st!,
                                                  style:  TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0XFF000000),
                                                      fontSize: 15.sp),
                                                )
                                              ],
                                            ),
                                             SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      plane[index].photo!),
                                                  height: 16.h,
                                                  width: 16.w,
                                                ),
                                                 SizedBox(width: 10.w),
                                                Text(
                                                  plane[index].planfacelity2nd!,
                                                  style:  TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0XFF000000),
                                                      fontSize: 15.sp),
                                                )
                                              ],
                                            ),
                                             SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      plane[index].photo!),
                                                  height: 16.h,
                                                  width: 16.w,
                                                ),
                                                 SizedBox(width: 10.w),
                                                Text(
                                                  plane[index].planfacelity3rd!,
                                                  style:  TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0XFF000000),
                                                      fontSize: 15.sp),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(bottom: 40.h),
                            child: payment_button(select),
                          ),
                        ],
                      ),
                    ),
              ))),
    );
  }

  Widget payment_button(bool select) {
    return select?GestureDetector(
      onTap: () {
        Get.to(const PaymenConfirm());
      },
      child: Container(
        height: 56.h,
        width: 374.w,
        //color: Color(0XFF23408F),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          color: const Color(0XFF23408F),
        ),
        child:  Center(
          child: Text("Payment",
              style: TextStyle(
                  color: const Color(0XFFFFFFFF),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy')),
        ),
      ),
    ):SizedBox() ;
  }
}
