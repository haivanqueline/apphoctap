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
        String videoUrl = widget.baiHoc.video!;
        print('Original video URL: $videoUrl');

        if (videoUrl.contains('127.0.0.1') || videoUrl.contains('localhost')) {
          videoUrl = videoUrl.replaceAll('https://', 'http://');
        }
        
        if (!videoUrl.startsWith('http')) {
          videoUrl = 'http://127.0.0.1:8000/storage/$videoUrl';
        }

        print('Final video URL: $videoUrl');

        final controller = VideoPlayerController.network(
          videoUrl,
          videoPlayerOptions: VideoPlayerOptions(
            mixWithOthers: true,
            allowBackgroundPlayback: false,
          ),
          httpHeaders: {
            'Access-Control-Allow-Origin': '*',
            'Accept': 'video/mp4,video/*;q=0.9,*/*;q=0.8',
          },
        );

        bool initialized = false;
        try {
          await controller.initialize().timeout(
            Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('Không thể tải video sau 10 giây');
            },
          );
          initialized = true;
        } catch (e) {
          print('Initialization error: $e');
          throw e;
        }

        if (!mounted) return;

        if (initialized && !controller.value.hasError) {
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
        } else {
          throw Exception('Không thể khởi tạo video player');
        }

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

  String _getErrorMessage(String error) {
    if (error.contains('MEDIA_ERR_SRC_NOT_SUPPORTED')) {
      return 'Video không được hỗ trợ. Vui lòng thử:\n'
          '1. Kiểm tra định dạng video (nên dùng MP4 với codec H.264)\n'
          '2. Kiểm tra kết nối mạng\n'
          '3. Đảm bảo URL video có thể truy cập được';
    } else if (error.contains('TimeoutException')) {
      return 'Không thể tải video. Vui lòng:\n'
          '1. Kiểm tra kết nối mạng\n'
          '2. Thử lại sau';
    } else if (error.contains('Format error') || error.contains('Video không hợp lệ')) {
      return 'Định dạng video không được hỗ trợ.\n'
          'Vui lòng chuyển đổi video sang định dạng MP4 (H.264)';
    }
    return 'Lỗi phát video: ${error.split('Exception:').last.trim()}';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header với nút back
              SizedBox(height: 26.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Image(
                    image: AssetImage("assets/back_arrow.png"),
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              
              // Video player
              SizedBox(height: 95.h),
              Center(
                child: Container(
                  height: 345.h,
                  child: _buildVideoPlayer(),
                ),
              ),

              // Nội dung bài học
              if (!hasError) Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.baiHoc.tenBaiHoc,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF23408F),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (widget.baiHoc.moTa != null) ...[
                        Text(
                          'Mô tả:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          widget.baiHoc.moTa!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
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
                        Text(
                          widget.baiHoc.noiDung!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (hasError) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 48),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _initializeVideo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF23408F),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (isVideoInitialized && flickManager != null) {
      return FlickVideoPlayer(
        flickManager: flickManager!,
        flickVideoWithControls: FlickVideoWithControls(
          controls: FlickPortraitControls(),
          videoFit: BoxFit.contain,
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF23408F)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }
}
