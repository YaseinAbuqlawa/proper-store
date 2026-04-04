class TopSellingItem {
  final String id;
  final String productId;
  final String productName;

  final String variantKey;
  final String variantName;
  final String imageUrl;
  final int totalSold;

  const TopSellingItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.variantKey,
    required this.variantName,
    required this.imageUrl,
    required this.totalSold,
  });
}
