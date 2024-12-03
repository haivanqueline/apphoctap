class User {
  final int id;
  final String code;
  final String global_id;
  final String full_name;
  final String username;
  final String email;
  final String password;
  final String email_verified_at;
  final String photo;
  final String phone;
  final String address;
  final String description;
  final int ship_id;
  final int ugroup_id;
  final String role;
  final int budget;
  final int totalpoint;
  final int totalrevenue;
  final String taxcode;
  final String taxname;
  final String taxaddress;
  final String status;

  User({
    required this.id,
    this.username = '',
    required this.email,
    required this.password,
    this.ugroup_id = 0,
    this.role = 'customer',
    required this.full_name,
    this.status = 'active',
    required this.phone,
    required this.address,
    this.code = '',
    this.global_id = '',
    this.description = '',
    this.ship_id = 0,
    this.email_verified_at = '',
    this.photo = '',
    this.budget = 0,
    this.totalpoint = 0,
    this.totalrevenue = 0,
    this.taxcode = '',
    this.taxname = '',
    this.taxaddress = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      ugroup_id: int.tryParse(json['ugroup_id'].toString()) ?? 0,
      role: json['role'] ?? 'customer',
      full_name: json['full_name'] ?? '',
      status: json['status'] ?? 'active',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      code: json['code'] ?? '',
      global_id: json['global_id']?.toString() ?? '',
      description: json['description'] ?? '',
      ship_id: int.tryParse(json['ship_id'].toString()) ?? 0,
      email_verified_at: json['email_verified_at'] ?? '',
      photo: json['photo'] ?? '',
      budget: int.tryParse(json['budget'].toString()) ?? 0,
      totalpoint: int.tryParse(json['totalpoint'].toString()) ?? 0,
      totalrevenue: int.tryParse(json['totalrevenue'].toString()) ?? 0,
      taxcode: json['taxcode'] ?? '',
      taxname: json['taxname'] ?? '',
      taxaddress: json['taxaddress'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'ugroup_id': ugroup_id,
      'role': role,
      'full_name': full_name,
      'status': status,
      'phone': phone,
      'address': address,
      'code': code,
      'global_id': global_id,
      'description': description,
      'ship_id': ship_id,
      'email_verified_at': email_verified_at,
      'photo': photo,
      'budget': budget,
      'totalpoint': totalpoint,
      'totalrevenue': totalrevenue,
      'taxcode': taxcode,
      'taxname': taxname,
      'taxaddress': taxaddress,
    };
  }
}
