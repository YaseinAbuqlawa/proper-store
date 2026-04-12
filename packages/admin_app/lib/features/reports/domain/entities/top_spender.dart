class TopSpender {
  final String customerId;
  final String name;
  final double totalSpent;
  final int orderCount;
  final int refundCount;

  const TopSpender({
    required this.customerId,
    required this.name,
    required this.totalSpent,
    required this.orderCount,
    this.refundCount = 0,
  });

  /// totalSpent already reflects rollbacks from refunds (done server-side).
  /// netSpent is an alias for clarity in the UI.
  double get netSpent => totalSpent;
}
