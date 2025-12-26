class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class NoInternetException extends AppException {
  const NoInternetException(super.message);
}

class ApiException extends AppException {
  const ApiException(super.message);
}
