import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/feedback_model.dart';
import '../models/user.dart';
import '../providers/feedback_provider.dart';
import 'feedback_list.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBack extends ConsumerStatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends ConsumerState<FeedBack> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  double _rating = 3.0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      
      try {
        final prefs = await SharedPreferences.getInstance();
        final userJson = prefs.getString('current_user');
        if (userJson != null) {
          final userData = json.decode(userJson);
          final user = User.fromJson(userData);

          final feedback = FeedbackModel(
            user_id: user.id,
            name: user.full_name,
            email: user.email,
            subject: "Đánh giá ứng dụng - Rating: $_rating",
            message: _messageController.text,
            status: 'pending',
          );

          print('Sending feedback: ${json.encode(feedback.toJson())}');

          await ref.read(feedbackNotifierProvider.notifier).createFeedback(feedback);
          
          Get.snackbar(
            'Thành công',
            'Cảm ơn bạn đã gửi đánh giá! Chúng tôi đã nhận được phản hồi của bạn.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(20),
            borderRadius: 10,
            icon: Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
          );
          
          await Future.delayed(Duration(seconds: 2));
          Get.back();
        } else {
          throw Exception('Không tìm thấy thông tin người dùng');
        }
      } catch (e) {
        print('Error submitting feedback: $e');
        Get.snackbar(
          'Lỗi',
          'Không thể gửi phản hồi: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(20),
          borderRadius: 10,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
        );
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      "assets/back_arrow.png",
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => const FeedbackList()),
                    child: Text(
                      "Xem Feedback",
                      style: TextStyle(
                        color: Color(0XFF23408F),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "Give Feedback",
                      style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Gilroy', fontSize: 28.sp),
                    ),
                    SizedBox(height: 12.h),
                    Text('Give your feedback about our app',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(0XFF000000),
                            fontFamily: 'Gilroy')),
                    SizedBox(height: 40.h),
                    Text("Are you satisfied with this app?",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Color(0XFF000000),
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 16.h),
                    ratingbar(),
                    SizedBox(height: 40.h),
                    Text("Tell us what can be improved!",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(0XFF000000),
                            fontFamily: 'Gilroy')),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.h))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.h),
                              borderSide:
                              BorderSide(color: Color(0XFF23408F), width: 1.w)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.h),
                              borderSide:
                              BorderSide(color: Color(0XFFDFDFDF), width: 1.w)),
                          hintText: 'Write your feedback...',
                          hintStyle: TextStyle(color: Color(0XFF6E758A), fontSize: 16.sp)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập nội dung feedback';
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              
              _isSubmitting
                  ? Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: _submitFeedback,
                      child: Container(
                        height: 56.h,
                        width: 374.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                          color: const Color(0XFF23408F),
                        ),
                        child: Center(
                          child: Text(
                            "Gửi Feedback",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget ratingbar() {
    return RatingBar(
      initialRating: _rating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 42,
      glow: false,
      ratingWidget: RatingWidget(
        full: Image(image: AssetImage("assets/fidbackfillicon.png"), height: 21.h, width: 21.w),
        half: Image(image: AssetImage("assets/fidbackemptyicon.png"), height: 21.h, width: 21.w),
        empty: Image(image: AssetImage("assets/fidbackemptyicon.png"), height: 21.h, width: 21.w),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 10),
      onRatingUpdate: (rating) {
        setState(() => _rating = rating);
        print('Rating updated: $_rating');
      },
    );
  }
}
