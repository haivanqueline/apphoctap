import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/screen_size.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child:const Image(image: AssetImage("assets/back_arrow.png"),height: 24,width: 24,)),
                const SizedBox(width: 15),
                const Text(
                  "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Gilroy', fontSize: 24),
                ),
              ],
            ),
             SizedBox(height: 30.h),
            question('1.Types of data we collect'),
             SizedBox(height: 10.h),
            answer(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec ac odio tempor orci dapibus ultrices in iaculis.'),
             SizedBox(height: 30.h),
            question('2. Disclosure of your data'),
             SizedBox(height: 10.h),
            answer(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec ac odio tempor orci dapibus ultrices in iaculis lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec ac odio tempor orci dapibus ultrices in iaculis Ac auctor augue mauris augue neque gravida. Velit ut tortor pretium viverra suspendisse. Volutpat commodo sed egestas egestas fringilla phasellus faucibus.'),
             SizedBox(height: 30.h),
            question('3. Use of your personal data'),
             SizedBox(height: 10.h),
            answer(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec ac odio tempor orci dapibus ultrices in iaculis lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec ac odio tempor orci dapibus ultrices in iaculis Ac auctor augue mauris augue neque gravida. Velit ut tortor pretium viverra suspendisse. Volutpat commodo sed egestas egestas fringilla phasellus faucibus. ')
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
        fontWeight: FontWeight.w700,
        color:const  Color(0XFF000000)
      ),
    );
  }

  answer(String s) {
    return Text(
      s,
      style:  TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.normal,
      color: Color(0XFF292929)),
    );
  }
}
