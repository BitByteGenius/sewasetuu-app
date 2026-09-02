/// Base domain failure abstraction
abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'A server error occurred. Please try again.', super.statusCode]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Please check your internet connection.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to read/write local cache.']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Session expired. Please log in again.', super.statusCode = 401]);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Invalid data provided.']);
}
