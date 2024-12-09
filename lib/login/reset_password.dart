// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/login/login_empty_state.dart';

import '../utils/screen_size.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool ispassHiden = false;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 16.h),
                back_button(),
                SizedBox(height: 20.h),
                 Center(
                  child: Text("Reset Password",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'Gilroy',
                          color: Color(0XFF000000),
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center),
                ),
                 SizedBox(height: 16.h),
                Expanded(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Enter password which are different from the previous paswords.",
                            style: TextStyle(
                                color: Color(0XFF000000),
                                fontSize: 15.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 20.h),
                      passwordtextfield('Password'),
                      SizedBox(height: 20.h),
                      passwordtextfield('Confirm password'),
                      SizedBox(height: 30),
                      done_button(),
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

  toggle() {
    setState(() {
      ispassHiden = !ispassHiden;
    });
  }

  Widget passwordtextfield(String i) {
    return TextFormField(
      obscureText: ispassHiden,
      decoration: InputDecoration(
          hintText: i,
          hintStyle:  TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Gilroy',
              color: const Color(0XFF9B9B9B),
              fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding:  EdgeInsets.only(left: 20.w),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:  BorderSide(color: const Color(0XFF23408F), width: 1.w)),
          enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0XFFDEDEDE),width: 1.w),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: ispassHiden
              ? GestureDetector(
                  onTap: () => toggle(),
                  child:  Image(
                    image: const AssetImage("assets/notvisible_eye.png"),
                    height: 20.h,
                    width: 20.w,
                  ))
              : GestureDetector(
                  onTap: () => toggle(),
                  child:  Image(
                    image: const AssetImage("assets/visible_eye.png"),
                    height: 20.h,
                    width: 20.w,
                  ))),
    );
  }

  Widget back_button() {
    return TextButton(
        onPressed: () {
         Get.back();
        },
        child:Image(
          image: const AssetImage("assets/back_arrow.png"),
          height: 24.h,
          width: 24.w,
        ));
  }

  Widget done_button() {
    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: const Color(0XFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actions: [
                Center(
                  child: Padding(
                    padding:  EdgeInsets.only(left: 15.w, right: 15.w),
                    child: Column(
                      children: [
                         SizedBox(height: 20.h),
                          Image(image:const  AssetImage("assets/Privacy2.png"),height: 88.13.h,width: 76.33.w,),
                         SizedBox(height: 20.h),
                         Text(
                          "Changed !",
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700),
                        ),
                         SizedBox(height: 20.h),
                         Align(
                          //alignment: Alignment.centerRight,
                          child: Text(
                            "Your password has been changed sucessfully ! ",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                         SizedBox(height: 20.h),
                        ok_button(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ); // Navigator.push(context,//     MaterialPageRoute(builder: (context) => const()));
        },
        child: Container(
          height: 56.h,
          width: 374.w,
          //color: Color(0XFF23408F),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0XFF23408F),
          ),
          child:  Center(
            child: Text("Done",
                style: TextStyle(
                    color: const Color(0XFFFFFFFF),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }

  Widget ok_button() {
    return Padding(
      padding:  EdgeInsets.only(top: 10.h, bottom: 20.h),
      child: Center(
        child: GestureDetector(
          onTap: () {

            Get.off(EmptyState());
          },
          child: Container(
            height: 56.h,
            width: 334.w,
            //color: Color(0XFF23408F),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0XFF23408F),
            ),
            child:  Center(
              child: Text("Ok",
                  style: TextStyle(
                      color: const Color(0XFFFFFFFF),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy')),
            ),
          ),
        ),
      ),
    );
  }
}
