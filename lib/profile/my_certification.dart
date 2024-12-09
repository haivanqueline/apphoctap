import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../utils/screen_size.dart';

class MyCertification extends StatefulWidget {
  const MyCertification({Key? key}) : super(key: key);

  @override
  State<MyCertification> createState() => _MyCertificationState();
}

class _MyCertificationState extends State<MyCertification> {
  MyCertificationScreenConyroller myCertificationScreenConyroller =
      Get.put(MyCertificationScreenConyroller());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        body: GetBuilder(
      init: MyCertificationScreenConyroller(),
      builder: (MyCertificationScreenConyroller) => Padding(
        padding:  EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
             SizedBox(height: 70.h),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image(image: const AssetImage("assets/back_arrow.png"),height: 24.h,width: 24.w,)),
                 SizedBox(width: 15.w),
                 Text(
                  "Certification",
                  style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Gilroy', fontSize: 24.sp),
                ),
              ],
            ),
             SizedBox(height: 70.h),
             Expanded(
               child: Image(
                  image: const AssetImage(
                    "assets/certificate.png",
                  ),
             ),
             ),
             SizedBox(height: 127.h),
            download_button(),
          ],
        ),
      ),
    ));
  }

  Widget download_button() {
    return GestureDetector(
      onTap: () {
        Get.snackbar("",
            'Download Complete');
      },
      child: Padding(
        padding:  EdgeInsets.only(bottom: 40.h, top: 15.h),
        child: Container(
          height: 56.h,
          width: 374.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            color: const Color(0XFF23408F),
          ),
          child:  Center(
            child: Text("Download Certificate",
                style: TextStyle(
                    color: const Color(0XFFFFFFFF),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }
}
