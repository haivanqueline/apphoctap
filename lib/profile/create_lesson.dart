import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../models/bai_hoc.dart';
import '../providers/learning_provider.dart';
import '../utils/screen_size.dart';

class CreateLesson extends StatefulWidget {
  final int khoaHocId;

  const CreateLesson({Key? key, required this.khoaHocId}) : super(key: key);

  @override
  State<CreateLesson> createState() => _CreateLessonState();
}

class _CreateLessonState extends State<CreateLesson> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _contentController;
  late TextEditingController _orderController;
  PlatformFile? _video;
  List<PlatformFile> _documents = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _contentController = TextEditingController();
    _orderController = TextEditingController();
    // Kiểm tra khóa học tồn tại
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LearningProvider>(context, listen: false);
      final khoaHoc = provider.myCourses.firstWhere(
        (course) => course.id == widget.khoaHocId,
        orElse: () => throw Exception('Không tìm thấy khóa học'),
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _contentController.dispose();
    _orderController.dispose();
    super.dispose();
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
                        _buildTextField(
                          controller: _nameController,
                          label: "Tên bài học",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên bài học';
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
                          controller: _contentController,
                          label: "Nội dung",
                          maxLines: 5,
                        ),
                        SizedBox(height: 20.h),
                        _buildTextField(
                          controller: _orderController,
                          label: "Thứ tự",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập thứ tự bài học';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Thứ tự không hợp lệ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildVideoPicker(),
                        SizedBox(height: 20.h),
                        _buildDocumentsList(),
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
          "Tạo bài học mới",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Gilroy',
          ),
        ),
      ],
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
      validator: (value) {
        if (validator != null) {
          return validator(value);
        }
        if (label == "Thứ tự") {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập thứ tự bài học';
          }
          try {
            int.parse(value.trim());
            return null;
          } catch (e) {
            return 'Thứ tự phải là số nguyên';
          }
        }
        return null;
      },
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

  Future<void> _pickVideo() async {
    try {
      if (kIsWeb) {
        // Sử dụng image_picker cho web
        final ImagePicker picker = ImagePicker();
        final XFile? video =
            await picker.pickVideo(source: ImageSource.gallery);

        if (video != null) {
          final bytes = await video.readAsBytes();
          setState(() {
            _video = PlatformFile(
              name: video.name,
              size: bytes.length,
              bytes: bytes,
            );
          });
        }
      } else {
        // Sử dụng file_picker cho mobile
        final result = await FilePicker.platform.pickFiles(
          type: FileType.video,
          allowMultiple: false,
        );

        if (result != null) {
          setState(() {
            _video = result.files.first;
          });
        }
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể chọn video: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _pickDocuments() async {
    try {
      if (kIsWeb) {
        // Sử dụng image_picker cho web
        final ImagePicker picker = ImagePicker();
        final List<XFile> files = await picker.pickMultiImage();

        if (files.isNotEmpty) {
          for (var file in files) {
            final bytes = await file.readAsBytes();
            setState(() {
              _documents.add(PlatformFile(
                name: file.name,
                size: bytes.length,
                bytes: bytes,
              ));
            });
          }
        }
      } else {
        // Sử dụng file_picker cho mobile
        final result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowMultiple: true,
        );

        if (result != null) {
          setState(() {
            _documents.addAll(result.files);
          });
        }
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể chọn tài liệu: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget _buildVideoPicker() {
    return GestureDetector(
      onTap: _pickVideo,
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFDEDEDE)),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library_outlined, size: 48.h),
            SizedBox(height: 10.h),
            Text(
              _video != null ? _video!.name : "Thêm video bài học",
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

  Widget _buildDocumentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickDocuments,
          child: Container(
            padding: EdgeInsets.all(15.h),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFDEDEDE)),
              borderRadius: BorderRadius.circular(20.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_file, size: 24.h),
                SizedBox(width: 10.w),
                Text(
                  "Thêm tài liệu",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_documents.isNotEmpty) ...[
          SizedBox(height: 10.h),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _documents.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_documents[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _documents.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildCreateButton() {
    return GestureDetector(
      onTap: _createLesson,
      child: Container(
        height: 56.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF23408F),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Center(
          child: Text(
            "Tạo bài học",
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

  void _createLesson() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_video == null) {
          Get.snackbar(
            'Lỗi',
            'Vui lòng chọn video bài học',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        final baiHoc = BaiHoc(
          tenBaiHoc: _nameController.text,
          moTa: _descController.text,
          idKhoahoc: widget.khoaHocId,
          noiDung: _contentController.text,
          thuTu: int.parse(_orderController.text),
          trangThai: 'active',
        );

        final result =
            await Provider.of<LearningProvider>(context, listen: false)
                .uploadLesson(
          baiHoc,
          videoBytes: _video?.bytes,
          videoName: _video?.name,
          documentFiles: _documents,
        );

        if (result != null) {
          Get.snackbar(
            'Thành công',
            'Tạo bài học thành công',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          await Future.delayed(Duration(seconds: 2));
          Get.back();
        } else {
          // Kiểm tra xem có lỗi từ provider không
          final error =
              Provider.of<LearningProvider>(context, listen: false).error;
          throw Exception(error ?? 'Không thể tạo bài học');
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
