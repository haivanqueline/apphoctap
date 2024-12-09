import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/home/home_main.dart';

import '../utils/screen_size.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:  EdgeInsets.only(right: 20.w, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 70.h),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child:  Image(
                    image: AssetImage("assets/back_arrow.png"),
                    height: 24.h,
                    width: 24.h,
                  )),
            ),
             SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "Give Feedback",
                    style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Gilroy', fontSize: 28.sp),
                  ),
                  SizedBox(height: 12.h),
                  Text('Give your feedback about our app',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0XFF000000),
                          fontFamily: 'Gilroy')),
                  SizedBox(height: 40.h),
                  Text("Are you satisfied with this app?",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Color(0XFF000000),
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 16.h),
                  ratingbar(),
                  SizedBox(height: 40.h),
                  Text("Tell us what can be improved!",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0XFF000000),
                          fontFamily: 'Gilroy')),
                  SizedBox(height: 20.h),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.h))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.h),
                            borderSide:
                            BorderSide(color: Color(0XFF23408F), width: 1.w)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.h),
                            borderSide:
                            BorderSide(color: Color(0XFFDFDFDF), width: 1.w)),
                        hintText: 'Write your feedback...',
                        hintStyle: TextStyle(color: Color(0XFF6E758A), fontSize: 16.sp)),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
              SizedBox(height: 40.h),
     
            submit_button(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  ratingbar() {
    return RatingBar(
      initialRating: 3,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 42,
      glow: false,

      ratingWidget: RatingWidget(
          full: Image(image: AssetImage("assets/fidbackfillicon.png"),height: 21.h,width: 21.w,),
          half: Image(image: AssetImage("assets/fidbackemptyicon.png"),height: 21.h,width: 21.w,),
          empty:Image(image: AssetImage("assets/fidbackemptyicon.png"),height: 21.h,width: 21.w,)
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 10),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  Widget submit_button() {
    return GestureDetector(
      onTap: () {
        Get.off(HomeMainScreen());
      },
      child: Container(
        height: 56.h,
        width: 374.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          color: const Color(0XFF23408F),
        ),
        child:  Center(
          child: Text("Submit Feedback",
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy')),
        ),
      ),
    );
  }
}
