import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../controller/controller.dart';
import '../models/chate_data.dart';
import '../models/chate_messege.dart';
import '../utils/screen_size.dart';

class DetailChate extends StatefulWidget {
  const DetailChate({Key? key, required this.detail}) : super(key: key);
  final Chate detail;

  @override
  State<DetailChate> createState() => _DetailChateState();
}

class _DetailChateState extends State<DetailChate> {
  String reciveMessege = 'receve';
  List<ChateMessage> chatemsseges = Utils.getChateMessage();
  DetailChateScreenController detailChateScreenController =
      Get.put(DetailChateScreenController());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: GetBuilder<DetailChateScreenController>(
          init: DetailChateScreenController(),
          builder: (DetailChateScreenController) => Padding(
            padding:  EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 79.h),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child:  Image(
                          image: AssetImage("assets/back_arrow.png"),
                          height: 24.h,
                          width: 24.w,
                        )),
                     SizedBox(width: 20.w),
                    Container(
                      height: 55.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.detail.photo!))),
                    ),
                     SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.detail.full_name!,
                              style:  TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis),
                           SizedBox(height: 2.h),
                          Row(
                            children:  [
                              Image(
                                image: const AssetImage("assets/notification.png"),
                                height: 12.h,
                                width: 12.w,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "Online",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                     SizedBox(width: 53.w),
                     Image(
                      image: AssetImage("assets/callicon.png"),
                      height: 24.h,
                      width: 24.w,
                    ),
                     SizedBox(width: 20.w),
                     Image(
                      image: AssetImage("assets/videocallicon.png"),
                      height: 24.h,
                      width: 24.w,
                    )
                  ],
                ),
                 SizedBox(height: 25.h),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    itemCount: chatemsseges.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (chatemsseges[index].type == reciveMessege) {
                        return messege_first(chatemsseges[index].message!,
                            chatemsseges[index].time!);
                      } else {
                        return send_messege(chatemsseges[index].message!,
                            chatemsseges[index].time!);
                      }
                    },
                  ),
                ),
                //const SizedBox(height: 235),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: 64.h),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Your message',
                                contentPadding: EdgeInsets.only(left: 21.w),
                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gilroy'),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.w, color: Color(0XFF23408F)),
                                    borderRadius: BorderRadius.circular(15.h)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.w, color: Color(0XFFB3B3B3)),
                                    borderRadius: BorderRadius.circular(15.h)),),
                            cursorColor: const Color(0XFF23408F),

                          ),
                        ),
                        SizedBox(width: 15.w),
                        Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0XFFB3B3B3),
                                width: 1),
                            borderRadius: BorderRadius.circular(15.h)

                            //borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                       child: Image(image: const AssetImage("assets/sendicon.png"),height: 24.h,width: 24.w,),
                          )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget messege_first(String m, String t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70.h,
          width: 250.w,
          decoration: BoxDecoration(

              borderRadius:  BorderRadius.only(
                  topRight: Radius.circular(15.h),
                  topLeft: Radius.circular(15.h),
                  bottomRight: Radius.circular(15.h)),
              color: Color(0XFF7D7D7D).withOpacity(0.07), boxShadow: [

          ],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: Center(
              child: Text(
                m,
                textAlign: TextAlign.start,
                style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy',
                    fontSize: 15.sp),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding:  EdgeInsets.only(left: 16.w),
          child: Text(
            t,
            style:  TextStyle(
                color: Color(0XFF7D7D7D),
                fontSize: 15.sp,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 22.h)
      ],
    );
  }

  Widget time_first(String s) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Text(
        s,
        style: TextStyle(
            color: Color(0XFF7D7D7D),
            fontSize: 15.sp,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget send_messege(String m, String t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 99.h,
            width: 250.w,

            // color: Colors.red,
            decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: const Color(0XFF000000).withOpacity(0.1),
                //       offset: const Offset(0, 2),
                //       blurRadius: 2),
                // ],
                borderRadius:  BorderRadius.only(
                    topRight: Radius.circular(15.h),
                    topLeft: Radius.circular(15.h),
                    bottomLeft: Radius.circular(15.h)),
                color: const Color(0XFFE5ECFF)),
            child: Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: Center(
                child: Text(
                  m,
                  textAlign: TextAlign.start,
                  style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy',
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
         SizedBox(height: 10.h),
        Padding(
          padding:  EdgeInsets.only(right: 10.w),
          child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                t,
                style:  TextStyle(
                    color: Color(0XFF7D7D7D),
                    fontSize: 15.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 4.w),
              Image(image: AssetImage("assets/done_all.png"),height: 16.h,width: 16.w,)
            ],
          ),
        ),
        SizedBox(height: 22.h)
      ],

    );
  }
}
