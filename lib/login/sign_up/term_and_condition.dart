import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/screen_size.dart';

class TermCondition extends StatefulWidget {
  const TermCondition({Key? key}) : super(key: key);

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 66.h),
            Row(
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
                 SizedBox(width: 15.w),
                 Text(
                  "Terms And Conditions",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
                ),
              ],
            ),
             SizedBox(height: 31.h),
            question('1.Types of data we collect'),
             SizedBox(height: 16.h),
            answer("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
             SizedBox(height: 31.h),
            question('2. Use of your personal Data'),
             SizedBox(height: 16.h),
            answer("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
             SizedBox(height: 31.h),
            question('3. Disclosure of your personal Data'),
             SizedBox(height: 16.h),
            answer("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
          ],
        ),
      ),
    );
  }

  question(String s) {
    return Text(
      s,
      style:  TextStyle(
          fontSize: 18.sp,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.bold,
          color: Color(0XFF000000)
      ),
    );
  }

  answer(String s) {
    return Text(
      s,
      style:  TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Gilroy',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          color: Color(0XFF6E758A)),
    );

  }
}
