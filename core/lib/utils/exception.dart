class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class HandShakeException implements Exception {
  final String message;

  HandShakeException(this.message);
}
