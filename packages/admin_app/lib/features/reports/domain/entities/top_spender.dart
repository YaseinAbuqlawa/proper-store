class TopSpender {
  final String customerId;
  final String name;
  final double totalSpent;
  final int orderCount;

  const TopSpender({
    required this.customerId,
    required this.name,
    required this.totalSpent,
    required this.orderCount,
  });
}
