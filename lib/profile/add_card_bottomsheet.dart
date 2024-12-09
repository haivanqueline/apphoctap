import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../providers/credit_card_provider.dart';
import '../models/credit_card.dart';

class CardBottomSheet extends StatefulWidget {
  const CardBottomSheet({Key? key}) : super(key: key);

  @override
  State<CardBottomSheet> createState() => _CardBottomSheetState();
}

class _CardBottomSheetState extends State<CardBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expirationMonthController =
      TextEditingController();
  final TextEditingController _expirationYearController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _cvvController.dispose();
    _expirationMonthController.dispose();
    _expirationYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.h)),
        ),
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Container(
                  height: 4.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    color: const Color(0XFF12121D),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add New Card",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF000000),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close, size: 24.sp),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              // Card Number Field
              _buildTextField(
                controller: _numberController,
                hint: "Card Number",
                icon: "assets/numberbox.png",
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) {
                  if (value?.isEmpty ?? true) return "Vui lòng nhập số thẻ";
                  if (value!.length != 16) return "Số thẻ phải có 16 chữ số";
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              // Card Holder Name Field
              _buildTextField(
                controller: _nameController,
                hint: "Card Holder Name",
                icon: "assets/profileicon1st.png",
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value?.isEmpty ?? true) return "Vui lòng nhập tên";
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              // Expiration Date and CVV Row
              Row(
                children: [
                  // Expiration Date Fields
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expiration Date",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            // Month Field
                            Expanded(
                              child: _buildTextField(
                                controller: _expirationMonthController,
                                hint: "MM",
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) return "MM";
                                  int? month = int.tryParse(value!);
                                  if (month == null ||
                                      month < 1 ||
                                      month > 12) {
                                    return "Invalid";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                "/",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // Year Field
                            Expanded(
                              child: _buildTextField(
                                controller: _expirationYearController,
                                hint: "YY",
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) return "YY";
                                  int? year = int.tryParse(value!);
                                  if (year == null) return "Invalid";
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  // CVV Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CVV",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          controller: _cvvController,
                          hint: "CVV",
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value?.isEmpty ?? true) return "CVV";
                            if (value!.length != 3) return "Invalid";
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              _buildAddButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLength,
    bool obscureText = false,
    TextAlign textAlign = TextAlign.start,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.h),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0XFF23408F).withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 8.h,
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: obscureText,
        textAlign: textAlign,
        textCapitalization: textCapitalization,
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Gilroy',
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hint,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          prefixIcon: icon != null
              ? Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Image.asset(icon, height: 24.h, width: 24.w),
                )
              : null,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16.sp,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Consumer<CreditCardProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: provider.isLoading
              ? null
              : () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newCard = CreditCard(
                      userId: 1,
                      cardNumber: _numberController.text.trim(),
                      cardHolderName: _nameController.text.trim(),
                      cvv: _cvvController.text.trim(),
                      expirationMonth: _expirationMonthController.text.trim(),
                      expirationYear:
                          "20${_expirationYearController.text.trim()}",
                    );

                    try {
                      await provider.addCreditCard(newCard);
                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Thêm thẻ thành công'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Lỗi: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
          child: Container(
            height: 56.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.h),
              color: const Color(0XFF23408F),
              boxShadow: [
                BoxShadow(
                  color: const Color(0XFF23408F).withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 12.h,
                ),
              ],
            ),
            child: Center(
              child: provider.isLoading
                  ? SizedBox(
                      height: 24.h,
                      width: 24.h,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      "Add Card",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
