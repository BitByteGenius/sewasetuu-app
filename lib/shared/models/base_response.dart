/// Generic API response envelope
class BaseResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final int? statusCode;

  const BaseResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return BaseResponse<T>(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      statusCode: json['status_code'] as int?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
