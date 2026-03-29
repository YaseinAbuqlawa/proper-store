class ServerFailure {
  final String code;

  const ServerFailure({required this.code});
}

class FirebaseFailure extends ServerFailure {
  const FirebaseFailure({required super.code});
}

class OutOfStockFailure extends ServerFailure {
  final String productName;
  final String variantName;
  final int available;

  const OutOfStockFailure({
    required this.productName,
    this.variantName = '',
    required this.available,
  }) : super(code: 'out_of_stock');
}
