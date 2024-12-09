import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../providers/credit_card_provider.dart';
import '../models/credit_card.dart';
import 'add_card_bottomsheet.dart';

class CertificatePayment extends StatefulWidget {
  const CertificatePayment({Key? key}) : super(key: key);

  @override
  State<CertificatePayment> createState() => _CertificatePaymentState();
}

class _CertificatePaymentState extends State<CertificatePayment> {
  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    try {
      await context.read<CreditCardProvider>().loadCreditCards();
    } catch (e) {
      print('Lỗi khi tải danh sách thẻ: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<CreditCardProvider>(
        builder: (context, creditCardProvider, child) {
          if (creditCardProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w),
            child: Column(
              children: [
                SizedBox(height: 70.h),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: Image(
                          image: const AssetImage("assets/back_arrow.png"),
                          height: 24.h,
                          width: 24.w,
                        )),
                    SizedBox(width: 15.w),
                    Text(
                      "Payment",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Gilroy',
                          fontSize: 24.sp),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: creditCardProvider.creditCards.length,
                    itemBuilder: (context, index) {
                      final card = creditCardProvider.creditCards[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child:
                            _buildCardItem(context, card, creditCardProvider),
                      );
                    },
                  ),
                ),
                add_new_card_button(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardItem(
      BuildContext context, CreditCard card, CreditCardProvider provider) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.h),
          boxShadow: [
            BoxShadow(
                color: const Color(0XFF23408F).withOpacity(0.14),
                offset: const Offset(-4, 5),
                blurRadius: 16.h),
          ],
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Image(
                    image: AssetImage("assets/done-all.png"),
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(width: 30.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "****${card.cardNumber.substring(card.cardNumber.length - 4)}",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Exp: ${card.expirationMonth}/${card.expirationYear}",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Gilroy',
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.h)),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Delete'),
                  onTap: () {
                    _showDeleteDialog(context, card.id!, provider);
                  },
                ),
              ],
              child: Image.asset(
                "assets/more_vert_round.png",
                height: 24.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(
      BuildContext context, int cardId, CreditCardProvider provider) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Xác nhận xóa",
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          "Bạn có chắc muốn xóa thẻ này không?",
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 16.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Hủy"),
          ),
          TextButton(
            onPressed: () {
              provider.deleteCreditCard(cardId);
              Navigator.pop(context);
            },
            child: Text("Xóa"),
          ),
        ],
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
          CardBottomSheet(),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
        child: Container(
          height: 56.h,
          width: 374.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            color: const Color(0XFF23408F),
          ),
          child: Center(
            child: Text(
              "Add New Card",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy'),
            ),
          ),
        ),
      ),
    );
  }
}
