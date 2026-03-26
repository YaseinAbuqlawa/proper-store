import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/features/auth/domain/use_cases/resume_facebook_redirect_use_case.dart';
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
  final ResumeFacebookRedirectUseCase _resumeFacebookRedirect;

  StreamSubscription<User?>? _subscription;

  AuthOrchestrationService({
    required FirebaseAuth auth,
    required ProfileCubit profileCubit,
    required FavoritesCubit favoritesCubit,
    required CartCubit cartCubit,
    required ResumeFacebookRedirectUseCase resumeFacebookRedirect,
  }) : _auth = auth,
       _profileCubit = profileCubit,
       _favoritesCubit = favoritesCubit,
       _cartCubit = cartCubit,
       _resumeFacebookRedirect = resumeFacebookRedirect;

  /// Initializes auth state listening and processes any pending Facebook
  /// redirect result from a previous mobile-web sign-in attempt.
  Future<void> init() async {
    // Process any pending Facebook redirect BEFORE starting the listener
    // so that authStateChanges emits only once (with the final auth state).
    await _resumeFacebookRedirect.call();

    _subscription = _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _profileCubit.getCustomerData();
        _cartCubit.loadCart(user.uid);
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
