import 'package:flutter/widgets.dart' show Color;

class ColorOption {
  final String name;
  final Color color;

  const ColorOption({required this.name, required this.color});

  factory ColorOption.fromJson(Map<String, dynamic> json) => ColorOption(
    name: json['name'] as String,
    color: Color(json['hex'] as int),
  );

  Map<String, dynamic> toJson() => {'name': name, 'hex': color.toARGB32()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorOption &&
          color.toARGB32() == other.color.toARGB32();

  @override
  int get hashCode => color.toARGB32().hashCode;

  @override
  String toString() => 'ColorOption(name: $name, color: $color)';
}
