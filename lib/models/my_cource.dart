class OngoingCources {
  final String? courceName;
  final String? courceImage;
  final int? id;

  OngoingCources({this.courceName, this.courceImage, this.id});

  // Phương thức chuyển đổi từ JSON sang OngoingCources
  factory OngoingCources.fromJson(Map<String, dynamic> json) {
    return OngoingCources(
      id: json['id'] as int?,
      courceName: json['ten_khoa_hoc'] as String?,
      courceImage: json['image'] as String?,
    );
  }

  // Phương thức chuyển đổi từ OngoingCources sang JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_khoa_hoc': courceName,
      'image': courceImage,
    };
  }
}