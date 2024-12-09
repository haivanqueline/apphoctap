// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';
import 'package:learn_megnagmet/home/home_main.dart';
import 'package:learn_megnagmet/models/payment_selection.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../profile/add_card_bottomsheet.dart';
import '../utils/screen_size.dart';

class PaymenConfirm extends StatefulWidget {
  const PaymenConfirm({Key? key}) : super(key: key);

  @override
  State<PaymenConfirm> createState() => _PaymenConfirmState();
}

class _PaymenConfirmState extends State<PaymenConfirm> {
  PaymentSelectionController paymentSelectionController =
      Get.put(PaymentSelectionController());

  bool select = false;
  List<Payment> selectPaymentType = Utils.getPayment();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          body: GetBuilder<PaymentSelectionController>(
              init: PaymentSelectionController(),
              builder: (controller) => SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image(
                                    image: const AssetImage(
                                        "assets/back_arrow.png"),
                                    height: 24.h,
                                    width: 24.w,
                                  )),
                              SizedBox(width: 15.w),
                              Text(
                                "Payment",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.sp,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 60.h,
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22.h),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0XFF23408F)
                                          .withOpacity(0.14),
                                      offset: const Offset(-4, 5),
                                      blurRadius: 16),
                                ],
                                color: Colors.white),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        fontFamily: 'Gilroy'),
                                  ),
                                  Text(
                                    "\$99",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        fontFamily: 'Gilroy',
                                        color: Color(0XFF23408F)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            "Select Payment",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700),
                          ),
                           SizedBox(height:20.h ),
                          Expanded(
                            child: ListView(
                              children: [ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: selectPaymentType.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 20.h),
                                      child: Container(
                                        height: 64.h,
                                        width: double.infinity.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.h),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color(0XFF23408F)
                                                      .withOpacity(0.14),
                                                  offset: const Offset(-4, 5),
                                                  blurRadius: 16.h),
                                            ],
                                            color: Colors.white),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 15.w, left: 15.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        selectPaymentType[index]
                                                            .photo!),
                                                    height: 24.h,
                                                    width: 24.w,
                                                  ),
                                                  SizedBox(width: 30.w),
                                                  Text(
                                                    selectPaymentType[index]
                                                        .title!,
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              Radio(
                                                  activeColor:
                                                      const Color(0XFF23408F),
                                                  value:
                                                      paymentSelectionController
                                                          .choice[index],
                                                  groupValue:
                                                      paymentSelectionController
                                                          .select,
                                                  onChanged: (value) {
                                                    paymentSelectionController
                                                        .onClickPaymentRadioButton(
                                                            value);
                                                    select = true;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }), add_new_button(),]
                            ),

                          ),

                          Padding(
                            padding: EdgeInsets.only(bottom: 30.h),
                            child: confirm_button(select),
                          )
                        ],
                      ),
                    ),
                  ))),
    );
  }

  Widget add_new_button() {
    return Center(
        child: GestureDetector(
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
      child: Text(
        "Add New +",
        style: TextStyle(
            fontSize: 18.sp, color: Color(0XFF23408F), fontFamily: 'Gilroy'),
      ),
    ));
  }

  confirm_button(bool select) {
    return select
        ? GestureDetector(
            onTap: () {
              Get.defaultDialog(
                  title: '',
                  barrierDismissible: false,
                  content: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/successpayment.png',
                        ),
                        height: 120.h,
                        width: 120.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Payment Successfull",
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                        style: TextStyle(
                            color: const Color(0XFF292929),
                            fontFamily: 'Gilroy',
                            fontSize: 15.sp,
                            fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.h, bottom: 20.h, right: 10.w, left: 10.w),
                        child: GestureDetector(
                          onTap: () {
                            Get.off(HomeMainScreen());
                          },
                          child: Container(
                            height: 56.h,
                            width: 374.w,
                            //color: Color(0XFF23408F),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.h),
                              color: const Color(0XFF23408F),
                            ),
                            child: Center(
                              child: Text("Back To Home",
                                  style: TextStyle(
                                      color: const Color(0XFFFFFFFF),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Gilroy')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            child: Container(
              height: 56,
              width: 374,
              //color: Color(0XFF23408F),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0XFF23408F),
              ),
              child: const Center(
                child: Text("Confirm",
                    style: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy')),
              ),
            ),
          )
        : const SizedBox();
  }
}
