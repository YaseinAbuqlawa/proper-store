import 'package:flutter/widgets.dart' show Color;

class ProductVariant {
  final String name;
  final Color color;
  final int stockQuantity;
  final List<String> imageUrls;

  const ProductVariant({
    required this.name,
    required this.color,
    this.stockQuantity = 0,
    this.imageUrls = const [],
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    name: json['name'] as String,
    color: Color(json['hex'] as int),
    stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
    imageUrls:
        (json['imageUrls'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        const [],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'hex': color.toARGB32(),
    'stockQuantity': stockQuantity,
    'imageUrls': imageUrls,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariant && color.toARGB32() == other.color.toARGB32();

  @override
  int get hashCode => color.toARGB32().hashCode;

  /// The Firestore map key for this variant (e.g. 'ffab0000').
  /// Derived from [color] using full ARGB hex (no '#' prefix, lowercase).
  String get hexKey => color.toARGB32().toRadixString(16);

  @override
  String toString() =>
      'ProductVariant(name: $name, color: $color, stock: $stockQuantity)';
}
