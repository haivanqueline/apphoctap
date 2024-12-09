import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../controller/controller.dart';
import '../models/payment_selection.dart';
import '../utils/screen_size.dart';
import 'add_card_bottomsheet.dart';

class CertificatePayment extends StatefulWidget {
  const CertificatePayment({Key? key}) : super(key: key);

  @override
  State<CertificatePayment> createState() => _CertificatePaymentState();
}

class _CertificatePaymentState extends State<CertificatePayment> {
  CertificatePaymentController certificatePaymentController =
      Get.put(CertificatePaymentController());
  List<Payment> paymentOption = Utils.getPayment();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder(
        init: CertificatePaymentController(),
        builder: (CertificatePaymentController) => Padding(
          padding: EdgeInsets.only(right: 20.w, left: 20.w),
          child: Column(
            children: [
              SizedBox(height: 70.h),
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
                    "Payment",
                    style:
                        TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Gilroy', fontSize: 24.sp),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: paymentOption.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Container(
                          height: 64,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.h),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0XFF23408F)
                                        .withOpacity(0.14),
                                    offset: const Offset(-4, 5),
                                    blurRadius: 16.h),
                              ],
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.w, left: 15.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          paymentOption[index].photo!),
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                    SizedBox(width: 30.w),
                                    Text(
                                      paymentOption[index].title!,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                PopupMenuButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.h)),
                                    child: Image.asset(
                                      "assets/more_vert_round.png",
                                      height: 24.h,
                                    ),
                                    itemBuilder:
                                        (BuildContext context) =>
                                            <PopupMenuEntry>[
                                              PopupMenuItem(
                                                value: 1,
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily: 'Gilroy',
                                                      color: Color(0XFF000000),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                        title: '',
                                                        content: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "Are you sure you want to delete card!",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0XFF000000),
                                                                  fontSize:
                                                                      24.sp,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 30
                                                                            .h,
                                                                        bottom:
                                                                            10.h),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Container(
                                                                      height:
                                                                          56.h,
                                                                      width: double
                                                                          .infinity
                                                                          .w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(22.h),
                                                                        color: const Color(
                                                                            0XFF23408F),
                                                                      ),
                                                                      child: Center(
                                                                          child: Text(
                                                                        "Yes",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: const Color(0XFFFFFFFF),
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 18.sp),
                                                                      )),
                                                                    )),
                                                                    SizedBox(
                                                                        width: 10.w),
                                                                    Expanded(
                                                                        child: Container(
                                                                            height: 56.h,
                                                                            width: double.infinity.w,
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                color: const Color(0xFF23408F),
                                                                                style: BorderStyle.solid,
                                                                                width: 1.0.w,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(22.h),
                                                                            ),
                                                                            child:  Center(
                                                                                child: Text(
                                                                              "No",
                                                                              style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700, color: Color(0xFF23408F), fontSize: 18.sp),
                                                                            ))))
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                  child:  Text('Delete',
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
                                                          fontFamily: 'Gilroy',
                                                          color:
                                                              Color(0XFF000000),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                         )),
                                                ),
                                              ),
                                            ]),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
             // SizedBox(height: 311),
              add_new_card_button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget add_new_card_button() {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.h),
                    topRight: Radius.circular(22.h))),
            CardBottomSheet());
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
            child: Text("Add New Card",
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
