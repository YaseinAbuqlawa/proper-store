class ServerFailure {
  final String code;

  const ServerFailure({required this.code});
}

class FirebaseFailure extends ServerFailure {
  const FirebaseFailure({required super.code});
}
