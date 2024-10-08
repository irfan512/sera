class NoInternetConnectException implements Exception {
  static const String _ERROR = 'User device is not connected to internet';

  const NoInternetConnectException();

  @override
  String toString() => _ERROR;
}

class UserAlreadyExistsWithDifferentCredential implements Exception {
  static const String _ERROR = 'User with this email already exists with different credentials';
  final List<String> authProviders;
  final String email;

  UserAlreadyExistsWithDifferentCredential({required this.authProviders, required this.email});

  @override
  String toString() => _ERROR;
}

class UserNotFoundException implements Exception {
  const UserNotFoundException();
}

class IdNotFoundException implements Exception {
  const IdNotFoundException();
}