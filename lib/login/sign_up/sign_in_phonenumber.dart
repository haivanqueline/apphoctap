// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:learn_megnagmet/login/sign_up/verification_screen.dart';

import '../../utils/screen_size.dart';

class SignInPhonenumber extends StatefulWidget {
  const SignInPhonenumber({Key? key}) : super(key: key);

  @override
  State<SignInPhonenumber> createState() => _SignInPhonenumberState();
}

class _SignInPhonenumberState extends State<SignInPhonenumber> {
  final phoneNumberkey = GlobalKey<FormState>();
  TextEditingController phoneNumberCheakController = TextEditingController();

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
                 SizedBox(
                  height: 16.h
                ),
                backbutton(),
                 SizedBox(height: 20.h),
                 Center(
                  child: Text(
                    "Enter your phone number",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Gilroy',
                        color: const Color(0XFF000000),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                 SizedBox(height: 16.h),
                 Padding(
                  padding: EdgeInsets.only(left: 55.w, right: 55.w),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "You will receive 4 digits number to verified number",
                      style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 15.sp,
                          fontFamily: 'Gilroy'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                 SizedBox(height: 22.h),
                phone_number_field(),
                 SizedBox(height: 30.h),
                Continuebutton(),
                 SizedBox(height: 100.h),
                //back_login_button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget backbutton() {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Image(
        image: const AssetImage("assets/back_arrow.png"),
        height: 24.h,
        width: 24.w,
      ),
    );
  }

  Widget phone_number_field() {
    return Form(
      key: phoneNumberkey,
      child: IntlPhoneField(
       dropdownIconPosition: IconPosition.trailing,
        dropdownIcon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0XFF000000),),
        flagsButtonPadding: EdgeInsets.only(left: 16.h),
        controller: phoneNumberCheakController,
        decoration: InputDecoration(

            labelText: 'Phone Number',
            labelStyle: TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
                color: Color(0XFF9B9B9B)),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
focusedErrorBorder: OutlineInputBorder(

    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.red, width: 1.w)),
            focusedBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0XFF23408F), width: 1.w)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.w),
              borderRadius: BorderRadius.circular(12),
            )),
        initialCountryCode: 'IN',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
        validator: (val) {
          if (val!.toString().isEmpty) return 'Please enter the mobile number';
          return null;
        },
      ),
    );
  }

  Widget Continuebutton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (phoneNumberkey.currentState!.validate()) {
            Get.to(const Verification());
          }
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
            child: Text("Continue",
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
}
