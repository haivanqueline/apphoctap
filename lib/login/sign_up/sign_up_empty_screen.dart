// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/login/login_empty_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_megnagmet/models/user.dart';
import 'package:learn_megnagmet/home/home_main.dart';

import '../../statenotifier/auth_state_notifier.dart';

class SignInEmptyScreen extends ConsumerWidget {
  const SignInEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPassController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    bool isPassHidden = true;
    bool isPassHidden1 = true;

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              backButton(context),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      fontFamily: 'Gilroy',
                      color: const Color(0XFF000000)),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    detailForm(
                      formKey,
                      nameController,
                      emailController,
                      passwordController,
                      confirmPassController,
                      phoneController,
                      addressController,
                      isPassHidden,
                      isPassHidden1,
                      (value) {
                        isPassHidden = value;
                      },
                      (value) {
                        isPassHidden1 = value;
                      },
                    ),
                    SizedBox(height: 25.h),
                    signUpButton(
                      ref,
                      formKey,
                      nameController,
                      emailController,
                      passwordController,
                      confirmPassController,
                      phoneController,
                      addressController,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: alreadyLoginButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailForm(
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPassController,
    TextEditingController phoneController,
    TextEditingController addressController,
    bool isPassHidden,
    bool isPassHidden1,
    Function(bool) togglePass,
    Function(bool) toggleConfirmPass,
  ) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: _inputDecoration('Name'),
            validator: (val) {
              if (val!.isEmpty) return 'Enter the Name';
              return null;
            },
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: emailController,
            decoration: _inputDecoration('Email'),
            validator: (val) {
              if (val!.isEmpty) return 'Enter the email';
              if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(val)) {
                return "Please enter valid email address";
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: phoneController,
            decoration: _inputDecoration('Phone'),
            validator: (val) {
              if (val!.isEmpty) return 'Enter the phone number';
              return null;
            },
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: addressController,
            decoration: _inputDecoration('Address'),
            validator: (val) {
              if (val!.isEmpty) return 'Enter the address';
              return null;
            },
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: passwordController,
            obscureText: isPassHidden,
            decoration: _passwordInputDecoration(isPassHidden, togglePass),
            validator: (val) {
              if (val!.isEmpty) return 'Enter the password';
              return null;
            },
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: confirmPassController,
            obscureText: isPassHidden1,
            decoration:
                _passwordInputDecoration(isPassHidden1, toggleConfirmPass),
            validator: (val) {
              if (val!.isEmpty) return 'Enter the confirm password';
              if (val != passwordController.text)
                return 'Passwords do not match';
              return null;
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: 15.sp,
          fontFamily: 'Gilroy',
          color: const Color(0XFF9B9B9B),
          fontWeight: FontWeight.bold),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0XFF23408F), width: 1.w)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      contentPadding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
    );
  }

  InputDecoration _passwordInputDecoration(
      bool isHidden, Function(bool) toggle) {
    return InputDecoration(
      suffixIcon: GestureDetector(
        onTap: () => toggle(!isHidden),
        child: Image(
          image: AssetImage(isHidden
              ? "assets/notvisible_eye.png"
              : "assets/visible_eye.png"),
          height: 20.h,
          width: 20.w,
        ),
      ),
      hintText: isHidden ? 'Password' : 'Confirm password',
      hintStyle: TextStyle(
          fontSize: 15.sp,
          fontFamily: 'Gilroy',
          color: const Color(0XFF9B9B9B),
          fontWeight: FontWeight.bold),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0XFF23408F), width: 1.w)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      contentPadding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
    );
  }

  Widget signUpButton(
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPassController,
    TextEditingController phoneController,
    TextEditingController addressController,
  ) {
    return Container(
      height: 56.h,
      width: 374.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0XFF23408F),
      ),
      child: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            try {
              User user = User(
                id: 0, // API sẽ tự sinh id
                full_name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                phone: phoneController.text,
                address: addressController.text,
              );

              await ref.read(authStateNotifierProvider.notifier).registerUser(user);
              Get.snackbar(
                "Success", 
                "Registration successful",
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.offAll(() => const HomeMainScreen());
            } catch (error) {
              Get.snackbar(
                "Error", 
                error.toString(),
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }
        },
        child: Text("Sign Up",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy')),
      ),
    );
  }

  Widget alreadyLoginButton() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
          text: TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                  color: Colors.black, fontSize: 15.sp, fontFamily: 'Gilroy'),
              children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.off(const EmptyState());
                },
              text: 'Login',
              style: TextStyle(
                  color: const Color(0XFF000000),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy'),
            )
          ])),
    );
  }

  Widget backButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context, true);
        },
        child: Image(
          image: const AssetImage("assets/back_arrow.png"),
          height: 24.h,
          width: 24.w,
        ));
  }
}
