/// Custom exceptions for the application

/// Base exception class
abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  NetworkException([String message = 'No internet connection'])
      : super(message, code: 'NETWORK_ERROR');
}

/// Server-related exceptions
class ServerException extends AppException {
  ServerException([String message = 'Server error occurred'])
      : super(message, code: 'SERVER_ERROR');
}

/// Authentication exceptions
class AuthException extends AppException {
  AuthException([String message = 'Authentication failed'])
      : super(message, code: 'AUTH_ERROR');
}

/// Not found exceptions
class NotFoundException extends AppException {
  NotFoundException([String message = 'Resource not found'])
      : super(message, code: 'NOT_FOUND');
}

/// Validation exceptions
class ValidationException extends AppException {
  ValidationException([String message = 'Validation failed'])
      : super(message, code: 'VALIDATION_ERROR');
}

/// Unauthorized exceptions
class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized access'])
      : super(message, code: 'UNAUTHORIZED');
}

/// Timeout exceptions
class TimeoutException extends AppException {
  TimeoutException([String message = 'Request timeout'])
      : super(message, code: 'TIMEOUT');
}

/// Generic app exception
class GenericException extends AppException {
  GenericException([String message = 'Something went wrong'])
      : super(message, code: 'GENERIC_ERROR');
}
