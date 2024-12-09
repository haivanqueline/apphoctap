import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/credit_card.dart';
import '../services/credit_card_service.dart';
import 'add_card_bottomsheet.dart';

class CertificatePayment extends StatefulWidget {
  const CertificatePayment({Key? key}) : super(key: key);

  @override
  State<CertificatePayment> createState() => _CertificatePaymentState();
}

class _CertificatePaymentState extends State<CertificatePayment> {
  final CreditCardService _creditCardService = CreditCardService();
  List<CreditCard> creditCards = [];

  @override
  void initState() {
    super.initState();
    _fetchCreditCards();
  }

  Future<void> _fetchCreditCards() async {
    creditCards = await _creditCardService.getAllCreditCards();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset("assets/back_arrow.png",
                      height: 24.h, width: 24.w),
                ),
                SizedBox(width: 15.w),
                Text("Payment",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 24.sp)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: creditCards.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.h),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              creditCards[index].cardHolderName ?? '',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.w700),
                            ),
                            // Thêm các hành động ở đây (ví dụ: xóa, chỉnh sửa)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _addNewCardButton(),
          ],
        ),
      ),
    );
  }

  Widget _addNewCardButton() {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.h),
                topRight: Radius.circular(22.h)),
          ),
          CardBottomSheet(),
        ).then(
            (_) => _fetchCreditCards()); // Làm mới danh sách thẻ sau khi thêm
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
        child: Container(
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            color: const Color(0XFF23408F),
          ),
          child: Center(
            child: Text("Add New Card",
                style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}
