class FeedbackModel {
  final int? id;
  final int? user_id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final String status;
  final String? created_at;
  final String? updated_at;

  FeedbackModel({
    this.id,
    this.user_id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    this.status = 'pending',
    this.created_at,
    this.updated_at,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] as int?,
      user_id: json['user_id'] as int?,
      name: json['name'] as String,
      email: json['email'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      status: json['status'] as String? ?? 'pending',
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id, // Thêm user_id vào request
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'status': status, // Thêm status vào request
    };
  }
}
