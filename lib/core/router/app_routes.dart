enum AppRoutes {
  welcome('/welcome'),
  home('/home'),
  orders('/orders'),
  productDetails('/productDetails/:id'),
  categories('/categories'),
  cart('/cart'),
  favorites('/favorites'),
  profile('/profile'),
  addresses('/addresses'),
  addAddress('/addAddress'),
  checkout('/checkout'),
  orderConfirmation('/orderConfirmation'),
  orderDetails('/orderDetails'),
  products('/products');

  final String path;
  const AppRoutes(this.path);
  String withId(String id) => path.replaceFirst(':id', id);
}
