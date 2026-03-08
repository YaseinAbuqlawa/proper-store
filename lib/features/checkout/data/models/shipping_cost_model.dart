class ShippingCostModel {
  final Map<String, double> areaCosts;

  const ShippingCostModel({required this.areaCosts});

  /// Returns the shipping cost for [city], or null if the city is not
  /// configured (meaning shipping is unavailable for that area).
  /// Returns 0.0 only when the city is explicitly configured as free.
  double? costForCity(String city) {
    final trimmedCity = city.trim();
    final key = areaCosts.keys.firstWhere(
      (k) => k.trim() == trimmedCity,
      orElse: () => '',
    );
    return key.isEmpty ? null : areaCosts[key]!;
  }

  factory ShippingCostModel.fromMap(Map<String, dynamic> map) {
    final costs = map.map(
      (key, value) => MapEntry(key, (value as num).toDouble()),
    );
    return ShippingCostModel(areaCosts: costs);
  }
}
