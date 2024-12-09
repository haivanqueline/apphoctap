import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/home/home_main.dart';
import 'package:learn_megnagmet/login/login_empty_state.dart';
import 'package:learn_megnagmet/onboarding/omboarding.dart';
import 'package:learn_megnagmet/utils/shared_pref.dart';

import '../utils/screen_size.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    getIntro();
  }

  getIntro() async {
    bool isIntro = await PrefData.getIntro();
    bool isLogin = await PrefData.getLogin();


    if (isIntro == false) {
      Timer(const Duration(seconds: 3), () => Get.to(const SlidePage()));
    } else if (isLogin == false) {
      Get.to(const EmptyState());
    } else {
      Get.to(const HomeMainScreen());
    }
  }

  // PrefData.setVarification(true);

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child:Container(height:95.h,width:95.h,child: Image(image: const AssetImage("assets/education_image.png"),fit: BoxFit.cover,))),
           Text(
            "Learn Management",
            style: TextStyle(
                fontSize: 28.sp,
                color: const Color(0XFF23408F),
                fontFamily: 'AvenirLTPro',
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
