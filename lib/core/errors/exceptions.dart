/// Base app exception abstraction
class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  AppException(this.message, {this.statusCode, this.details});

  @override
  String toString() => 'AppException(statusCode: $statusCode, message: $message)';
}

class ServerException extends AppException {
  ServerException({String message = 'Server error', int? statusCode, dynamic details})
      : super(message, statusCode: statusCode, details: details);
}

class CacheException extends AppException {
  CacheException({String message = 'Cache operation failed'}) : super(message);
}

class NetworkException extends AppException {
  NetworkException({String message = 'Network connection failed'}) : super(message);
}

class AuthException extends AppException {
  AuthException({String message = 'Authentication failed', int? statusCode})
      : super(message, statusCode: statusCode);
}
