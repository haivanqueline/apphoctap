import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/home/home_main.dart';
import 'package:learn_megnagmet/login/forgot_password.dart';
import 'package:learn_megnagmet/login/sign_up/sign_up_empty_screen.dart';
import 'package:learn_megnagmet/providers/login_provider.dart';
import 'package:learn_megnagmet/utils/shared_pref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final passwordVisibilityProvider = StateProvider<bool>((ref) => true);

class EmptyState extends ConsumerWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formkey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image(
                    image: const AssetImage("assets/back_arrow.png"),
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    primary: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 20.h),
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                              fontFamily: 'Gilroy',
                              color: Color(0XFF000000)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Center(
                          child: Text(
                        "Glad to meet you again!",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF000000),
                            fontSize: 15.sp,
                            fontFamily: 'Gilroy',
                            fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      )),
                      SizedBox(height: 10.h),
                      email_password_form(
                          formkey, emailController, passwordController, ref),
                      SizedBox(height: 21.h),
                      forgotpassword(),
                      SizedBox(height: 40.h),
                      loginbutton(
                          ref, formkey, emailController, passwordController),
                      SizedBox(height: 40.h),
                      or_sign_in_with_text(),
                      SizedBox(height: 41.h),
                      login_google(),
                      SizedBox(height: 20.h),
                      login_facebook(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: sign_up(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget email_password_form(
      GlobalKey<FormState> formkey,
      TextEditingController emailController,
      TextEditingController passwordController,
      WidgetRef ref) {
    bool ispassHiden = ref.watch(passwordVisibilityProvider);

    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy',
                  color: const Color(0XFF9B9B9B),
                  fontWeight: FontWeight.w700),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0XFF23408F), width: 1.w),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              contentPadding:
                  EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Enter the email';
              } else {
                if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                    .hasMatch(val)) {
                  return 'Please enter valid email address';
                }
              }
              return null;
            },
          ),
          SizedBox(height: 15.h),
          TextFormField(
            controller: passwordController,
            obscureText: ispassHiden,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy',
                  color: const Color(0XFF9B9B9B),
                  fontWeight: FontWeight.w700),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0XFF23408F), width: 1.w),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              contentPadding:
                  EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
              suffixIcon: GestureDetector(
                onTap: () {
                  // Đổi trạng thái hiển thị mật khẩu
                  ref.read(passwordVisibilityProvider.notifier).state =
                      !ispassHiden;
                },
                child: Image(
                  image: ispassHiden
                      ? const AssetImage("assets/notvisible_eye.png")
                      : const AssetImage("assets/visible_eye.png"),
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Enter the password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget forgotpassword() {
    return GestureDetector(
      onTap: () {
        Get.to(const ForgotPassword());
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          "Forgot password?",
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
            color: Color(0XFF23408F),
          ),
        ),
      ),
    );
  }

  Widget loginbutton(
      WidgetRef ref,
      GlobalKey<FormState> formkey,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          try {
            if (formkey.currentState!.validate()) {
              await ref
                  .read(loginProvider.notifier)
                  .login(emailController.text, passwordController.text);

              // Kiểm tra trạng thái đăng nhập
              if (ref.read(loginProvider) == LoginStatus.success) {
                PrefData.setLogin(true);
                Get.to(const HomeMainScreen());
              } else {
                Get.snackbar(
                    'Error', 'Login failed. Please check your credentials.');
              }
            }
          } catch (e) {
            Get.snackbar('Error', 'An unexpected error occurred: $e');
          }
        },
        child: Container(
          height: 56.h,
          width: 374.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0XFF23408F),
          ),
          child: Center(
            child: Text("Log In",
                style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }

  Widget login_google() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56.h,
        width: 374.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withOpacity(0.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/google.png")),
            SizedBox(width: 10.w),
            Text(
              "Login with Google",
              style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget login_facebook() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56.h,
        width: 374.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withOpacity(0.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/facebook.png")),
            SizedBox(width: 10.w),
            Text(
              "Login with Facebook",
              style: TextStyle(
                  color: const Color(0XFF000000),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget sign_up() {
    return Center(
      child: RichText(
          text: TextSpan(
              text: 'Don\'t have an account?',
              style: TextStyle(
                  color: Colors.black, fontSize: 15.sp, fontFamily: 'Gilroy'),
              children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(const SignInEmptyScreen());
                },
              text: ' Sign up',
              style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy'),
            )
          ])),
    );
  }

  Widget or_sign_in_with_text() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 0.h,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: const Color(0XFFDEDEDE),
          ),
        ),
        GestureDetector(
          child: Text("OR Sign in with",
              style: TextStyle(
                  color: const Color(0XFF000000),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gilroy',
                  fontStyle: FontStyle.normal)),
        ),
        Expanded(
          child: Divider(
            height: 0.h,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: const Color(0XFFDEDEDE),
          ),
        )
      ],
    );
  }
}
