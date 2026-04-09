import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRemoteDataSource {
  final FirebaseAuth auth;

  const AuthRemoteDataSource({required this.auth});

  Future<StaffModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(code: 'user-not-found');
    }

    final idTokenResult = await user.getIdTokenResult().timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw FirebaseAuthException(
          code: 'timeout',
          message: 'Firebase taking too long to fetch token.',
        );
      },
    );
    final roleString = idTokenResult.claims?['role'] as String?;

    if (roleString == null) {
      throw FirebaseAuthException(code: 'not-found');
    }

    final role = StaffRole.fromString(roleString);
    if (role == null) {
      throw FirebaseAuthException(code: 'not-found');
    }

    return StaffModel(uid: user.uid, email: user.email ?? '', role: role);
  }

  Future<StaffModel?> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) return null;

    final idTokenResult = await user.getIdTokenResult().timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw FirebaseAuthException(code: 'timeout');
      },
    );
    final roleString = idTokenResult.claims?['role'] as String?;
    final role = StaffRole.fromString(roleString);
    if (role == null) return null;

    return StaffModel(uid: user.uid, email: user.email ?? '', role: role);
  }

  Future<void> signOut() => auth.signOut();
}
