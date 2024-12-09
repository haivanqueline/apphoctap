class OngoingCources {
  final int id;
  final String courceName;
  final String courceImage;
  

  OngoingCources({required this.courceName, required this.courceImage, required this.id});

  // Phương thức chuyển đổi từ JSON sang OngoingCources
  factory OngoingCources.fromJson(Map<String, dynamic> json) {
    return OngoingCources(
      id: json['id'],
      courceName: json['ten_khoa_hoc'],
      courceImage: json['image'],
      
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
