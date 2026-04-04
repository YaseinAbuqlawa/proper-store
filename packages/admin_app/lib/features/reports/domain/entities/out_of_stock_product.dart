class OutOfStockProduct {
  final String productId;
  final String name;
  final List<String> outOfStockVariants;
  final String? mainImageUrl;

  const OutOfStockProduct({
    required this.productId,
    required this.name,
    required this.outOfStockVariants,
    this.mainImageUrl,
  });
}
