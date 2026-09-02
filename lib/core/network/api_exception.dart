import 'package:dio/dio.dart';

/// Network specific exceptions mapped from Dio errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory ApiException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ApiException(message: 'Request was cancelled');
      case DioExceptionType.connectionTimeout:
        return ApiException(message: 'Connection timeout with server');
      case DioExceptionType.sendTimeout:
        return ApiException(message: 'Send timeout in connection with server');
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Receive timeout in connection with server');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final responseData = dioError.response?.data;
        String errorMessage = 'Received invalid status code: $statusCode';
        if (responseData is Map && responseData.containsKey('message')) {
          errorMessage = responseData['message'].toString();
        }
        return ApiException(
          message: errorMessage,
          statusCode: statusCode,
          data: responseData,
        );
      case DioExceptionType.connectionError:
        return ApiException(message: 'No internet connection available');
      default:
        return ApiException(message: 'Something went wrong. Please try again.');
    }
  }

  @override
  String toString() => message;
}
