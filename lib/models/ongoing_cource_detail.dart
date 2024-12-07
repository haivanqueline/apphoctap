class CourceDetails {
  final String? lessonName; // Tên bài học
  final String? time;       // Thời gian (hoặc thời gian tạo)
  final int? lessonID;      // ID bài học
  final int? courceID;      // ID khóa học
  final String? playIconImage; // Icon play (có thể không cần nếu API không trả về)
  final String? lockImageImage; // Icon lock (có thể không cần nếu API không trả về)
  final String? url;        // URL video bài học

  CourceDetails({
    this.lessonName,
    this.time,
    this.lessonID,
    this.courceID,
    this.playIconImage,
    this.lockImageImage,
    this.url,
  });

  // Factory constructor để chuyển từ JSON sang object
  factory CourceDetails.fromJson(Map<String, dynamic> json) {
    return CourceDetails(
      lessonName: json['ten_bai_hoc'],           // Map từ API "ten_bai_hoc"
      time: json['created_at'],                  // Map từ API "created_at"
      lessonID: _parseInt(json['id']),           // Sử dụng _parseInt để chuyển đổi từ String sang int
      courceID: _parseInt(json['id_khoahoc']),   // Sử dụng _parseInt để chuyển đổi từ String sang int
      url: json['video'],                        // Map từ API "video"
      playIconImage: null,                       // Không có trong API, để mặc định là null
      lockImageImage: null,                      // Không có trong API, để mặc định là null
    );
  }

  // Phương thức chuyển từ object sang JSON (nếu cần gửi lên server)
  Map<String, dynamic> toJson() {
    return {
      'ten_bai_hoc': lessonName,
      'created_at': time,
      'id': lessonID,
      'id_khoahoc': courceID?.toString(),
      'video': url,
    };
  }

  // Hàm giúp chuyển đổi String sang int an toàn
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);  // Chuyển đổi String thành int
    }
    return null;  // Trả về null nếu không thể chuyển đổi
  }
}