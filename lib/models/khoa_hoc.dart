class KhoaHoc {
  final int? id;
  final String tenKhoaHoc;
  final String? moTa;
  final String? image;
  final double gia;
  final String? thumbnail;
  final String trangThai;
  final int? createdBy;
  final String? createdByName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  KhoaHoc({
    this.id,
    required this.tenKhoaHoc,
    this.moTa,
    this.image,
    required this.gia,
    this.thumbnail,
    this.trangThai = 'active',
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
  });

  factory KhoaHoc.fromJson(Map<String, dynamic> json) {
    return KhoaHoc(
      id: json['id'],
      tenKhoaHoc: json['ten_khoa_hoc'],
      moTa: json['mo_ta'],
      image: json['image'],
      gia: double.parse(json['gia'].toString()),
      thumbnail: json['thumbnail'],
      trangThai: json['trang_thai'] ?? 'active',
      createdBy: json['created_by'],
      createdByName: json['created_by_name'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_khoa_hoc': tenKhoaHoc,
      'mo_ta': moTa,
      'image': image,
      'gia': gia,
      'thumbnail': thumbnail,
      'trang_thai': trangThai,
      'created_by': createdBy,
      'created_by_name': createdByName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}