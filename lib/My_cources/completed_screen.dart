import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:learn_megnagmet/utils/slider_page_data_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controller/controller.dart';
import '../utils/screen_size.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  CompletedController completedController = Get.put(CompletedController());
  List completedCource = Utils.getCompletedCource();
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(
        init: CompletedController(),
        builder: (completedController) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(itemCount:completedCource.length,itemBuilder: (context,index){
                    return Padding(
                      padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: index==0?0.h:8.h,bottom:8.h),
                      child: Container(
                        height: 124.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                  const Color(0XFF23408F).withOpacity(0.14),
                                  offset: const Offset(-4, 5),
                                  blurRadius: 16.h),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                          child: Row(

                            children: [
                              Image(image: AssetImage(completedCource[index].courceImage),height: 100.h,width: 100.w,),
                               SizedBox(width: 10.w),
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   SizedBox(height: 20.h),
                                  Text(completedCource[index].courceName,style:  TextStyle(fontSize: 18.sp,fontFamily: 'Gilroy',fontStyle: FontStyle.normal),),
                                   SizedBox(height: 10.h),
                                   Text("8 Lesson ",style: TextStyle(color: Color(0XFF292929),fontSize: 14.sp,fontFamily: 'Gilroy',fontWeight: FontWeight.w400),),
                                   SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      LinearPercentIndicator(
                                        padding: EdgeInsets.zero,
                                        width: 180.0.w,
                                        lineHeight: 6.0.h,
                                        percent: 1.0,
                                        trailing: Padding(
                                          padding:  EdgeInsets.only(left: 12.w),
                                          child: Text("100%",style: TextStyle(fontFamily: 'Gilroy',fontSize: 14,fontWeight: FontWeight.w400),),
                                        ),
                                        backgroundColor: const Color(0XFFDEDEDE),
                                        progressColor: const Color(0XFF23408F),
                                        barRadius:  Radius.circular(22.w),

                                      ),

                                    ],
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            )
        ));
  }
}
