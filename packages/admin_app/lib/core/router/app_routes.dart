enum AppRoutes {
  login('/login'),
  orders('/orders'),
  products('/products'),
  customers('/customers'),
  storeConfig('/store-config');

  const AppRoutes(this.path);

  final String path;
}
