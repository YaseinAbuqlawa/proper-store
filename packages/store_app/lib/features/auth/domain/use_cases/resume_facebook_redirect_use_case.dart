import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/features/auth/domain/repo/auth_repo.dart';
import 'package:proper_store_shared/models/customer_model.dart';

/// Processes the pending [UserCredential] that Firebase stores after a
/// [signInWithRedirect] flow on mobile web.
///
/// Must be called once at app startup (web-only). If a redirect was pending,
/// Firebase resolves the credential, [authStateChanges] fires, and new users
/// get a Firestore customer doc created.
@lazySingleton
class ResumeFacebookRedirectUseCase {
  final AuthRepo _repo;
  ResumeFacebookRedirectUseCase({required AuthRepo repo}) : _repo = repo;

  Future<void> call() async {
    if (!kIsWeb) return;

    final result = await _repo.getRedirectResult();

    await result.fold(
      (_) async {}, // silently ignore failures — no redirect was pending
      (credential) async {
        if (credential == null) return;
        if (credential.additionalUserInfo?.isNewUser != true) return;

        final customer = CustomerModel(
          id: credential.user!.uid,
          name: credential.user!.displayName ?? 'مجهول',
          email: credential.user!.email ?? '',
          photoUrl: credential.user!.photoURL ?? '',
        );

        await _repo.addNewCustomer(customer: customer);
      },
    );
  }
}
