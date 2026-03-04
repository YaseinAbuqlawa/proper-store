import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:proper_store/features/profile/presentation/cubit/profile_cubit.dart';

/// Listens to Firebase auth state changes and coordinates app-level cubits
/// and router refresh in response. Extracted from main.dart for testability
/// and separation of concerns.
@lazySingleton
class AuthOrchestrationService {
  final FirebaseAuth _auth;
  final ProfileCubit _profileCubit;
  final FavoritesCubit _favoritesCubit;
  final CartCubit _cartCubit;

  StreamSubscription<User?>? _subscription;

  AuthOrchestrationService({
    required FirebaseAuth auth,
    required ProfileCubit profileCubit,
    required FavoritesCubit favoritesCubit,
    required CartCubit cartCubit,
  }) : _auth = auth,
       _profileCubit = profileCubit,
       _favoritesCubit = favoritesCubit,
       _cartCubit = cartCubit;

  void init() {
    _subscription = _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _profileCubit.getCustomerData();
      } else {
        _profileCubit.clearProfileData();
        _favoritesCubit.clearFavorites();
        _cartCubit.clearCart();
      }
      appRouter.refresh();
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
