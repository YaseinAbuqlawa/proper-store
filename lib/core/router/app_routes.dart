enum AppRoutes {
  auth('/auth'),
  home('/home'),
  orders('/orders'),
  categories('/categories'),
  cart('/cart'),
  favorites('/favorites'),
  profile('/profile');

  final String path;
  const AppRoutes(this.path);
}
