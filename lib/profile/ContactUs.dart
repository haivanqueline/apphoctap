import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../utils/screen_size.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  List contect=Utils.getContect();
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return ListView.builder(itemCount: contect.length,itemBuilder: (context,index){return Padding(
      padding:  EdgeInsets.only(top: 8.h,bottom: 8.h,right: 20.w,left: 20.w),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.h),
            boxShadow: [
              BoxShadow(
                  color: Color(0XFF23408F).withOpacity(0.14),
                  offset: Offset(-4, 5),
                  blurRadius: 16.h),
            ],
            color: Colors.white),
        child: Padding(
          padding:  EdgeInsets.only(left: 15.w,right: 15.w),
          child: Row(
            children: [
              Image(image: AssetImage(contect[index].contectIcon),height: 24.h,width: 24.w,),
              SizedBox(width: 10.w),
              Text(contect[index].contectTitle,style: TextStyle(fontSize: 15.sp,fontFamily: 'Gilroy',fontWeight: FontWeight.w700),)
            ],
          ),
        ),
      ),
    );});
  }
}
