enum AppRoutes {
  login('/login'),
  orders('/orders'),
  products('/products'),
  productsAdd('/products/add'),
  productsEdit('/products/edit'),
  customers('/customers'),
  storeConfig('/store-config'),
  orderDetails('/orders/details'),
  customerOrders('/customers/orders'),
  customerFavorites('/customers/favorites'),
  staff('/staff');

  const AppRoutes(this.path);

  final String path;
}
