import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CardBottomSheet extends StatefulWidget {
  const CardBottomSheet({Key? key}) : super(key: key);

  @override
  State<CardBottomSheet> createState() => _CardBottomSheetState();
}

class _CardBottomSheetState extends State<CardBottomSheet> {
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  Future<void> addCard() async {
    final url = 'http://127.0.0.1:8000/api/v1/credit-cards';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': '3',
        'card_number': cardNumberController.text,
        'card_holder_name': cardHolderController.text,
        'cvv': cvvController.text,
      }),
    );

    if (response.statusCode == 201) {
      Get.snackbar('Success', 'Card added successfully!');
      Get.back();
    } else {
      Get.snackbar('Error', 'Failed to add card');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 5.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2.5.h),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Add New Card",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 25.h),
          cardField("Name On Card", Icons.person, cardHolderController),
          SizedBox(height: 15.h),
          cardField("Card Number", Icons.credit_card, cardNumberController),
          SizedBox(height: 15.h),
          cardField("CVV", Icons.lock, cvvController, isNumber: true),
          SizedBox(height: 25.h),
          addButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  date_and_cvv_field(String s) {
    return Expanded(
      child: Container(
        height: 60.h,
        width: double.infinity.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.h),
            boxShadow: [
              BoxShadow(
                  color: const Color(0XFF23408F).withOpacity(0.14),
                  offset: const Offset(-4, 5),
                  blurRadius: 16.h),
            ],
            color: Colors.white),
        child: Padding(
          padding:  EdgeInsets.all(8.0.h),
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: s,
              contentPadding: EdgeInsets.only(left: 18.w,top:18.h ,bottom: 14.h),
              border: InputBorder.none,
            ),
            style:  TextStyle(
                fontSize: 15.sp,
                color: Color(0XFF6E758A),
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return ElevatedButton(
      onPressed: addCard,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      child: Center(
        child: Text(
          "Add Card",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}