enum AppRoutes {
  auth('/auth'),
  home('/home'),
  orders('/orders'),
  productDetails('/productDetails/:id'),
  categories('/categories'),
  cart('/cart'),
  favorites('/favorites'),
  profile('/profile');

  final String path;
  const AppRoutes(this.path);
  String withId(String id) => path.replaceFirst(':id', id);
}
