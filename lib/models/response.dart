class Response {
  final bool success;
  final String message;
  final dynamic data;

  Response({
    required this.success,
    required this.message,
    this.data,
  });

  factory Response.success(dynamic data) {
    return Response(
      success: true,
      message: 'Success',
      data: data,
    );
  }

  factory Response.error(String message) {
    return Response(
      success: false,
      message: message,
    );
  }
}