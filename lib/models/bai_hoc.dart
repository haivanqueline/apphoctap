import 'dart:convert';

class BaiHoc {
  final int? id;
  final String tenBaiHoc;
  final String? moTa;
  final int idKhoahoc;
  final String? video;
  final String? noiDung;
  final List<TaiLieu>? taiLieu;
  final int thuTu;
  final int? thoiLuong;
  final int? luotXem;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaiHoc({
    this.id,
    required this.tenBaiHoc,
    this.moTa,
    required this.idKhoahoc,
    this.video,
    this.noiDung,
    this.taiLieu,
    required this.thuTu,
    this.thoiLuong,
    this.luotXem,
    this.trangThai = 'active',
    this.createdAt,
    this.updatedAt,
  });

  factory BaiHoc.fromJson(Map<String, dynamic> json) {
    print('Parsing BaiHoc from JSON: $json');
    
    List<TaiLieu>? taiLieuList;
    if (json['taiLieu'] != null && json['taiLieu'] != "[]") {
      try {
        var taiLieuData = json['taiLieu'] is String 
            ? jsonDecode(json['taiLieu']) 
            : json['taiLieu'];
        
        if (taiLieuData is List) {
          taiLieuList = taiLieuData
              .map((item) => TaiLieu.fromJson(item))
              .toList();
        }
      } catch (e) {
        print('Error parsing taiLieu: $e');
      }
    }

    return BaiHoc(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      tenBaiHoc: json['tenBaiHoc']?.toString() ?? '',
      moTa: json['moTa']?.toString(),
      idKhoahoc: json['idKhoahoc'] is String 
          ? int.tryParse(json['idKhoahoc']) ?? 0 
          : json['idKhoahoc'] ?? 0,
      video: json['video']?.toString(),
      noiDung: json['noiDung']?.toString(),
      taiLieu: taiLieuList,
      thuTu: json['thuTu'] is String 
          ? int.tryParse(json['thuTu']) ?? 0 
          : json['thuTu'] ?? 0,
      thoiLuong: json['thoiLuong'] is String 
          ? int.tryParse(json['thoiLuong']) 
          : json['thoiLuong'],
      luotXem: json['luotXem'] is String 
          ? int.tryParse(json['luotXem']) 
          : json['luotXem'],
      trangThai: json['trangThai']?.toString() ?? 'active',
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'].toString()) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'].toString()) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_bai_hoc': tenBaiHoc,
      'mo_ta': moTa,
      'id_khoahoc': idKhoahoc,
      'video': video,
      'noi_dung': noiDung,
      'tai_lieu': taiLieu?.map((x) => x.toJson()).toList(),
      'thu_tu': thuTu,
      'thoi_luong': thoiLuong,
      'luot_xem': luotXem,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class TaiLieu {
  final String name;
  final String path;

  TaiLieu({
    required this.name,
    required this.path,
  });

  factory TaiLieu.fromJson(Map<String, dynamic> json) {
    return TaiLieu(
      name: json['name'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
    };
  }
}

