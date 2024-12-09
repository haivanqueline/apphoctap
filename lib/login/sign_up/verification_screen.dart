// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/home/home_main.dart';

import '../../utils/screen_size.dart';
import '../../utils/shared_pref.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final otpkey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  String? otp;

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
                    "Verification",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Gilroy',
                        color: Color(0XFF000000),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                 SizedBox(height: 20.h),
                 Expanded(
                   child: ListView(
                     children: [
                       Align(
                         alignment: Alignment.center,
                         child: Text(
                           "We sent to the 99*******5",
                           style: TextStyle(
                               color: Color(0XFF000000),
                               fontSize: 15.sp,
                               fontFamily: 'Gilroy',
                               fontWeight: FontWeight.bold),
                           textAlign: TextAlign.center,
                         ),
                       ),
                       SizedBox(height: 20.h),
                       otpformat(),
                       SizedBox(height: 30.h),
                       Confirmbutton(),
                     ],
                   ),
                 ),

                Padding(
                  padding:  EdgeInsets.only(bottom: 30.h),
                  child: resend_otp_button(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget otpformat() {
    return Form(
      key: otpkey,
      child: OtpTextField(

        numberOfFields: 4,
        borderColor: const Color(0xFFDEDEDE),
        showFieldAsBox: true,
        borderRadius: BorderRadius.circular(12),
       borderWidth: 1,
        focusedBorderColor: Color(0XFF23408F),
        fieldWidth: 79.w,


        onSubmit: (value) {
          setState(() {
            otp = value;
          });
        },
      ),
    );
  }

  Widget backbutton() {
    return TextButton(
        onPressed: () {
         Get.back();
        },
        child: const Icon(Icons.arrow_back_ios, color: Color(0XFF000000)));
  }

  Widget Confirmbutton() {
    return Center(
        child: GestureDetector(
      onTap: () {

        print("otp length ${otp!.length}");
        otp != null?Get.defaultDialog(

          title: '',
          //middleText: '',
            content: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children:  [
                  Image(
                      image:
                      AssetImage("assets/User_Approved.png"),height: 90.h,width: 78.w,),
                   SizedBox(height: 30.h),
                   Text(
                    "Sucessful !",
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold),
                  ),
                   SizedBox(height: 20.h),
                   Text(
                     "Your password has been changed sucessfully ! ",
                     style: TextStyle(
                         fontSize: 15.sp,
                         fontFamily: 'Gilroy',
                         fontWeight: FontWeight.w700),
                     textAlign: TextAlign.center,
                   ),
                   SizedBox(height: 32.h),

                  ok_button(),
                ],
              ),
            ),



        )

            : Fluttertoast.showToast(
                msg: "Please enter the OTP",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0.sp);

        // Navigator.
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
          child: Text("Confirm",
              style: TextStyle(
                  color: const Color(0XFFFFFFFF),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy')),
        ),
      ),
    ));
  }

  Widget resend_otp_button() {
    return Center(
      child: RichText(
          text: TextSpan(
              text: 'Don’t receive code?',
              style:  TextStyle(color: Colors.black, fontSize: 15.sp, fontFamily: 'Gilroy'),
              children: [
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () {},
              text: ' Resend',
              style:  TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0XFF000000),
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal
              ),
            )
          ])),
    );
  }

  Widget ok_button() {
    return Padding(
      padding:  EdgeInsets.only( bottom: 20.h),
      child: Center(
        child: GestureDetector(
          onTap: () {
            PrefData.setLogin(true);
            Get.to(const HomeMainScreen()
            );
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
                      color: Color(0XFFFFFFFF),
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
