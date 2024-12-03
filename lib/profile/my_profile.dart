// ignore: unnecessary_import
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/models/profile.dart';
import 'package:learn_megnagmet/profile/edit_screen.dart';
import 'package:learn_megnagmet/profile/feedback.dart';
import 'package:learn_megnagmet/profile/help_center.dart';
import 'package:learn_megnagmet/profile/my_certification.dart';
import 'package:learn_megnagmet/profile/my_project.dart';
import 'package:learn_megnagmet/profile/privacy_policy.dart';
import 'package:learn_megnagmet/profile/rate_us.dart';
import 'package:learn_megnagmet/profile/saved_cource.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../controller/controller.dart';
import '../login/login_empty_state.dart';
import '../models/profile_option.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';
import 'certi_payment.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.profile_detail}) : super(key: key);
  final Profile profile_detail;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  MyProfileController myProfileController = Get.put(MyProfileController());
  List<ProfileOption> profileoption = Utils.getProfileOption();
  List profileOptionClass = [
    MyCertification(),
    MyProject(),
    SavedCourse(),
    CertificatePayment(),
    HelpCenter(),
    PrivacyPolicy(),
    FeedBack(),
    RateUs(),
  ];
  HomeMainController controller = Get.put(HomeMainController());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: GetBuilder(
          init: MyProfileController(),
          builder: (MyProfileController) => SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        },
                        child: Image(
                          image: AssetImage("assets/back_arrow.png"),
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        "My Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Image(
                  image: widget.profile_detail.photo.isNotEmpty
                      ? NetworkImage(widget.profile_detail.photo)
                      : AssetImage("assets/default_avatar.png") as ImageProvider,
                  height: 100.h,
                  width: 100.w,
                ),
                SizedBox(height: 12.h),
                Text(
                  widget.profile_detail.full_name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700,
                    color: const Color(0XFF000000),
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditScreen(
                              profile: widget.profile_detail,
                            ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Edit Profile",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF000000))),
                      Image(
                        image: AssetImage("assets/editsymbol.png"),
                        height: 16.h,
                        width: 16.w,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView(
                    primary: true,
                    shrinkWrap: false,
                    children: [
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: profileoption.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10.h, top: index == 0 ? 0.h : 10.h, left: 20.w, right: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  if ((index == profileOptionClass.length - 1)) {
                                    rateUs_dialogue();
                                  } else {
                                    if (index == 1 || index == 2) {
                                      return;
                                    } else {
                                      Get.to(profileOptionClass[index]);
                                    }
                                  }
                                },
                                child: Container(
                                    height: 60.h,
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center, children: [
                                          Row(
                                            children: [
                                              SizedBox(width: 15.w),
                                              Image(
                                                image: AssetImage(profileoption[index].icon!),
                                                height: 24.h,
                                                width: 24.w,
                                              ),
                                              SizedBox(width: 15.w),
                                              Text(
                                                profileoption[index].title!,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: 'Gilroy',
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center, children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 15.w),
                                            child: Row(
                                              children: [
                                                Image(image: const AssetImage("assets/right_arrow.png"), height: 24.h, width: 24.w,)
                                              ],
                                            ),
                                          )
                                        ],),
                                      ],
                                    )),
                              ),
                            );
                          }),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 40.h, left: 20.h, right: 20.h),
                        child: GestureDetector(
                          onTap: () {
                            log_out_dialogue();
                          },
                          child: Container(
                            height: 56.h,
                            width: 374.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF23408F),
                                style: BorderStyle.solid,
                                width: 1.0.w,
                              ),
                              borderRadius: BorderRadius.circular(20.h),
                            ),
                            child: Center(
                              child: Text("Logout",
                                  style: TextStyle(
                                      color: const Color(0xFF23408F),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future rateUs_dialogue() {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.w),
              child: Image(
                image: const AssetImage('assets/rateUs.png'),
                height: 174.h,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.w),
              child: Text(
                "Give Your Opinion",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Make better math goal for you, and would love to know how would rate our app?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            RatingBar(
              initialRating: 3,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              glow: false,
              ratingWidget: RatingWidget(
                full: Image(image: AssetImage("assets/fidbackfillicon.png"),),
                half: Image(image: AssetImage("assets/fidbackemptyicon.png"),),
                empty: Image(image: AssetImage("assets/fidbackemptyicon.png"),)
              ),
              itemPadding: EdgeInsets.symmetric(horizontal: 10),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 56.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            color: const Color(0XFF23408F),
                          ),
                          child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700,
                                    color: Color(0XFFFFFFFF),
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.sp),
                              )),
                        ),
                      )),
                   SizedBox(width: 10.w),
                  Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.back();
                          controller.onChange(0);
                        },
                        child: Container(
                            height: 56.h,
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF23408F),
                                style: BorderStyle.solid,
                                width: 1.0.w,
                              ),
                              borderRadius: BorderRadius.circular(22.h),
                            ),
                            child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF23408F),
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18.sp),
                                ))),
                      )),
                ],
              ),
            )
          ],
        ));
  }

  Future log_out_dialogue() {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
               Text(
                "Are you sure you want to Logout!",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy'),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.only(top: 25.h, bottom: 13.h),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            PrefData.setLogin(false);
                                Get.off(EmptyState());
                          },
                          child: Container(
                            height: 56.h,
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.h),
                              color: const Color(0XFF23408F),
                            ),
                            child: Center(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.bold,
                                      color: Color(0XFFFFFFFF),
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18.sp),
                                )),
                          ),
                        )),
                     SizedBox(width: 10.w),
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              height: 56.h,
                              width: double.infinity.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF23408F),
                                  style: BorderStyle.solid,
                                  width: 1.0.w,
                                ),
                                borderRadius: BorderRadius.circular(22.h),
                              ),
                              child: Center(
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF23408F),
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.sp),
                                  ))),
                        )),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}
