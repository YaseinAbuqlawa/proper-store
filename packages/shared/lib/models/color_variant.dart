import 'package:flutter/widgets.dart' show Color;

class ColorVariant {
  final String name;
  final Color color;
  final int stockQuantity;
  final List<String> imageUrls;

  const ColorVariant({
    required this.name,
    required this.color,
    this.stockQuantity = 0,
    this.imageUrls = const [],
  });

  factory ColorVariant.fromJson(Map<String, dynamic> json) => ColorVariant(
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
      other is ColorVariant &&
          color.toARGB32() == other.color.toARGB32();

  @override
  int get hashCode => color.toARGB32().hashCode;

  @override
  String toString() =>
      'ColorVariant(name: $name, color: $color, stock: $stockQuantity)';
}
