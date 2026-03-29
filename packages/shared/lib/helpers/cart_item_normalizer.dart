/// Ensures all required [CartItemModel] fields are present by deriving
/// missing ones from their counterparts (variantKey ↔ selectedColor, id).
Map<String, dynamic> normalizeCartItemJson(Map<String, dynamic> m) {
  if (m['variantKey'] == null) {
    final colorInt = (m['selectedColor'] as num?)?.toInt();
    m['variantKey'] =
        colorInt != null ? colorInt.toRadixString(16).padLeft(8, '0') : '';
  }
  if (m['selectedColor'] == null) {
    final vk = m['variantKey'] as String? ?? '';
    m['selectedColor'] = int.tryParse(vk, radix: 16) ?? 0;
  }
  if (m['id'] == null) {
    final productId = m['productId'] as String? ?? '';
    final colorInt = (m['selectedColor'] as num).toInt();
    m['id'] = '$productId$colorInt';
  }
  return m;
}
