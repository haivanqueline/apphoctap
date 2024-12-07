class UserKhoaHoc {
  final int? id;
  final int userId;
  final int khoaHocId;
  final DateTime? expiryDate;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserKhoaHoc({
    this.id,
    required this.userId,
    required this.khoaHocId,
    this.expiryDate,
    this.status = 'active',
    this.createdAt,
    this.updatedAt,
  });

  factory UserKhoaHoc.fromJson(Map<String, dynamic> json) {
    return UserKhoaHoc(
      id: json['id'],
      userId: json['user_id'],
      khoaHocId: json['khoa_hoc_id'],
      expiryDate: json['expiry_date'] != null 
          ? DateTime.parse(json['expiry_date']) 
          : null,
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'khoa_hoc_id': khoaHocId,
      'expiry_date': expiryDate?.toIso8601String(),
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}