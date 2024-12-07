// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../models/bai_hoc.dart';
import '../utils/screen_size.dart';

class LessonPlay extends StatefulWidget {
  const LessonPlay({Key? key, required this.baiHoc}) : super(key: key);
  final BaiHoc baiHoc;

  @override
  State<LessonPlay> createState() => _LessonPlayState();
}

class _LessonPlayState extends State<LessonPlay> {
  FlickManager? flickManager;
  bool isVideoInitialized = false;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (widget.baiHoc.video != null && widget.baiHoc.video!.isNotEmpty) {
      try {
        print('Initializing video from URL: ${widget.baiHoc.video}');
        
        if (!_isValidVideoUrl(widget.baiHoc.video!)) {
          throw Exception('URL video không hợp lệ');
        }

        final controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.baiHoc.video!),
          videoPlayerOptions: VideoPlayerOptions(
            mixWithOthers: true,
          ),
        );

        await controller.initialize().timeout(
          Duration(seconds: 10),
          onTimeout: () {
            throw TimeoutException('Không thể tải video sau 10 giây');
          },
        );
        
        if (!mounted) return;

        setState(() {
          flickManager = FlickManager(
            videoPlayerController: controller,
            autoPlay: false,
            autoInitialize: true,
          );
          isVideoInitialized = true;
          hasError = false;
          errorMessage = '';
        });
      } catch (e) {
        print('Video initialization error: $e');
        if (!mounted) return;
        setState(() {
          hasError = true;
          errorMessage = _getErrorMessage(e.toString());
        });
      }
    }
  }

  bool _isValidVideoUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('MEDIA_ERR_SRC_NOT_SUPPORTED') || 
        error.contains('Format error') ||
        error.contains('VideoError')) {
      return 'Định dạng video không được hỗ trợ. Vui lòng thử định dạng khác (MP4, WebM).';
    } else if (error.contains('TimeoutException')) {
      return 'Không thể tải video, vui lòng kiểm tra kết nối mạng và thử lại.';
    } else if (error.contains('PLATFORM_EXCEPTION')) {
      return 'Thiết bị không hỗ trợ phát video này. Vui lòng thử trên thiết bị khác.';
    }
    return 'Không thể phát video: ${error.split(':').last}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.baiHoc.tenBaiHoc),
        backgroundColor: Color(0xFF23408F),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: _buildVideoPlayer(),
              ),
            ),
            if (hasError) ...[
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: _initializeVideo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF23408F),
                ),
                child: Text('Thử lại'),
              ),
            ],
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.baiHoc.moTa != null) ...[
                      Text(
                        'Mô tả:',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(widget.baiHoc.moTa!),
                    ],
                    if (widget.baiHoc.noiDung != null) ...[
                      SizedBox(height: 16.h),
                      Text(
                        'Nội dung:',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(widget.baiHoc.noiDung!),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    if (isVideoInitialized && flickManager != null) {
      return FlickVideoPlayer(flickManager: flickManager!);
    }

    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF23408F)),
      ),
    );
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }
}
