// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/models/profile.dart';
import 'package:learn_megnagmet/providers/profile_provider.dart';
import '../constant/enum.dart';
import '../utils/screen_size.dart';

class EditScreen extends ConsumerStatefulWidget {
  const EditScreen({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  ConsumerState<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.full_name);
    emailController = TextEditingController(text: widget.profile.email);
    phoneController = TextEditingController(text: widget.profile.phone);
    addressController = TextEditingController(text: widget.profile.address);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              buildHeader(),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView(
                  children: [
                    buildProfileImage(),
                    SizedBox(height: 30.h),
                    buildTextField(
                      "assets/profileicon1st.png",
                      nameController,
                      "Họ tên",
                      onChanged: (value) => ref.read(profileProvider.notifier).updatefull_name(value),
                    ),
                    SizedBox(height: 20.h),
                    buildTextField(
                      "assets/profileicon2nd.png",
                      emailController,
                      "Email",
                      enabled: true,
                      onChanged: (value) => ref.read(profileProvider.notifier).updateEmail(value),
                    ),
                    SizedBox(height: 20.h),
                    buildTextField(
                      "assets/profileicon3rd.png",
                      phoneController,
                      "Số điện thoại",
                      onChanged: (value) => ref.read(profileProvider.notifier).updatePhone(value),
                    ),
                    SizedBox(height: 20.h),
                    buildTextField(
                      "assets/profileicon3rd.png",
                      addressController,
                      "Địa chỉ",
                      onChanged: (value) => ref.read(profileProvider.notifier).updateAddress(value),
                    ),
                  ],
                ),
              ),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        SizedBox(width: 16.w),
        Text(
          "Chỉnh sửa thông tin",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            fontFamily: 'Gilroy',
          ),
        ),
      ],
    );
  }

  Widget buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50.h,
            backgroundImage: AssetImage(widget.profile.photo),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFF23408F),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () {
                  // Thêm chức năng chọn ảnh ở đây
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String icon,
    TextEditingController controller,
    String hint, {
    bool enabled = true,
    Function(String)? onChanged,
  }) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.h),
        boxShadow: [
          BoxShadow(
            color: const Color(0XFF23408F).withOpacity(0.14),
            offset: const Offset(-4, 5),
            blurRadius: 16,
          ),
        ],
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          prefixIcon: Padding(
            padding: EdgeInsets.all(7.0.h),
            child: Image.asset(icon, height: 24.h, width: 24.h),
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 15.sp,
          color: Color(0XFF6E758A),
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildSaveButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: GestureDetector(
        onTap: () async {
          try {
            final notifier = ref.read(profileProvider.notifier);
            notifier.updatefull_name(nameController.text);
            notifier.updatePhone(phoneController.text);
            notifier.updateAddress(addressController.text);
            
            await notifier.saveProfile();
            
            final state = ref.read(profileProvider);
            if (state.updateStatus == UpdateStatus.success) {
              Get.back();
              Get.snackbar(
                'Thành công',
                'Cập nhật thông tin thành công',
                snackPosition: SnackPosition.BOTTOM,
              );
            } else {
              Get.snackbar(
                'Lỗi',
                state.errorMessage ?? 'Có lỗi xảy ra khi cập nhật',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          } catch (e) {
            Get.snackbar(
              'Lỗi',
              'Có lỗi xảy ra: ${e.toString()}',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: Container(
          height: 56.h,
          width: 374.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            color: const Color(0XFF23408F),
          ),
          child: Center(
            child: Text(
              "Lưu thay đổi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Gilroy',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
