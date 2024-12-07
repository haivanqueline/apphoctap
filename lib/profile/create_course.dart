import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import '../models/khoa_hoc.dart';
import '../providers/learning_provider.dart';
import '../utils/screen_size.dart';

class CreateCourse extends StatefulWidget {
  const CreateCourse({Key? key}) : super(key: key);

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  PlatformFile? _thumbnail;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickThumbnail() async {
    try {
      if (kIsWeb) {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          final bytes = await image.readAsBytes();
          setState(() {
            _thumbnail = PlatformFile(
              name: image.name,
              size: bytes.length,
              bytes: bytes,
            );
          });
        }
      } else {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );

        if (result != null) {
          setState(() {
            _thumbnail = result.files.first;
          });
        }
      }
    } catch (e) {
      print('Error picking thumbnail: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể chọn ảnh: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildHeader(),
              SizedBox(height: 30.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildThumbnailPicker(),
                        SizedBox(height: 20.h),
                        _buildTextField(
                          controller: _nameController,
                          label: "Tên khóa học",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên khóa học';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildTextField(
                          controller: _descController,
                          label: "Mô tả",
                          maxLines: 3,
                        ),
                        SizedBox(height: 20.h),
                        _buildTextField(
                          controller: _priceController,
                          label: "Giá (VNĐ)",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập giá khóa học';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Giá không hợp lệ';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildCreateButton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 24.h),
        ),
        SizedBox(width: 15.w),
        Text(
          "Tạo khóa học mới",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Gilroy',
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnailPicker() {
    return GestureDetector(
      onTap: _pickThumbnail,
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFDEDEDE)),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: _thumbnail != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20.h),
                child: Image.memory(
                  _thumbnail!.bytes!,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, size: 48.h),
                  SizedBox(height: 10.h),
                  Text(
                    "Thêm ảnh thumbnail",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.h),
          borderSide: BorderSide(color: Color(0xFFDEDEDE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.h),
          borderSide: BorderSide(color: Color(0xFF23408F)),
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return GestureDetector(
      onTap: _createCourse,
      child: Container(
        height: 56.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF23408F),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Center(
          child: Text(
            "Tạo khóa học",
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
  }

  void _createCourse() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_thumbnail == null) {
          // Sử dụng ảnh mặc định từ assets nếu không có thumbnail được chọn
          final defaultImageBytes =
              await rootBundle.load('assets/images/bill.jpg');
          _thumbnail = PlatformFile(
            name: 'bill.jpg',
            size: defaultImageBytes.lengthInBytes,
            bytes: defaultImageBytes.buffer.asUint8List(),
          );
        }

        final khoaHoc = KhoaHoc(
          tenKhoaHoc: _nameController.text,
          moTa: _descController.text,
          gia: double.parse(_priceController.text),
          trangThai: 'active',
          createdBy: null,
        );

        final result =
            await Provider.of<LearningProvider>(context, listen: false)
                .createCourse(
          khoaHoc,
          thumbnailBytes: _thumbnail?.bytes,
          thumbnailName: _thumbnail?.name,
        );

        if (result != null) {
          Get.snackbar(
            'Thành công',
            'Tạo khóa học thành công',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          await Future.delayed(Duration(seconds: 2));
          Get.back();
        }
      } catch (e) {
        String errorMessage = e.toString();
        if (errorMessage.contains('Exception:')) {
          errorMessage = errorMessage.split('Exception:')[1].trim();
        }
        Get.snackbar(
          'Lỗi',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    }
  }
}
