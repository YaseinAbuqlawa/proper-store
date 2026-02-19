import 'package:intl/intl.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

extension ProductListExt on List<ProductModel> {
  double get totalPriceBeforeDiscount => fold(
    0,
    (pervious, current) => pervious + (current.sellingPrice * current.quantity),
  );
  double get totalDiscount => fold(
    0,
    (pervious, current) =>
        pervious + (current.discountValue * current.quantity),
  );
  double get totalPriceAfterDiscount => fold(
    0,
    (pervious, current) => pervious + (current.offerPrice() * current.quantity),
  );
}

extension DoubleExt on double {
  String toCurrency() {
    var format = NumberFormat.currency(decimalDigits: 2, symbol: "ج٫م");
    return format.format(this);
  }
}
