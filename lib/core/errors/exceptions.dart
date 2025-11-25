class APIException implements Exception {
  const APIException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;
}

class CacheException implements Exception {
  const CacheException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;
}