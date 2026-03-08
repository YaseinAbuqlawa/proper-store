sealed class ProductFilter {
  const ProductFilter();
}

final class ProductFilterAll extends ProductFilter {
  const ProductFilterAll();
}

final class ProductFilterByCategory extends ProductFilter {
  final String category;
  const ProductFilterByCategory(this.category);
}
