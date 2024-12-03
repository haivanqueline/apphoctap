import 'package:learn_megnagmet/models/user.dart';

class Profile {
  String email;
  String full_name;
  String phone;
  String address;
  String photo;

  Profile({
    required this.email,
    required this.full_name,
    required this.phone,
    required this.address,
    required this.photo,
  });

  // Tạo phương thức từ JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'] ?? '',
      full_name: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      photo: json['avatar_url'] ?? '',
    );
  }

  // Chuyển đổi Profile thành JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'full_name': full_name,
      'phone': phone,
      'address': address,
      'avatar_url': photo,
    };
  }

  Profile copyWith({
    String? email,
    String? full_name,
    String? phone,
    String? address,
    String? photo,
  }) {
    return Profile(
      email: email ?? this.email,
      full_name: full_name ?? this.full_name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      photo: photo ?? this.photo,
    );
  }

  // Thêm phương thức chuyển đổi từ User sang Profile
  static Profile fromUser(User user) {
    return Profile(
      email: user.email,
      full_name: user.full_name,
      phone: user.phone,
      address: user.address,
      photo: user.photo,
    );
  }
}
