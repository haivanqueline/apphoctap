class Lecturer {
  final int id;
  final String magv;
  final String name;
  final String email;
  final String? phoneNumber;  
  final String? degree;       
  final String? biography;    
  final String? faculty;    
  final String? major;       
  final String? specialization; 

  Lecturer({
    required this.id,
    required this.magv,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.degree,
    this.biography,
    this.faculty,
    this.major,
    this.specialization,
  });

  factory Lecturer.fromJson(Map<String, dynamic> json) {
    return Lecturer(
      id: json['id'] as int,
      magv: json['magv'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      degree: json['degree'] as String?,
      biography: json['biography'] as String?,
      faculty: json['faculty'] as String?,
      major: json['major'] as String?,
      specialization: json['specialization'] as String?,
    );
  }
}
