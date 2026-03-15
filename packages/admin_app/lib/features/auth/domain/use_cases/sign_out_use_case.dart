import 'package:injectable/injectable.dart';

import 'package:admin/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class SignOutUseCase {
  final AuthRepo repo;

  const SignOutUseCase({required this.repo});

  Future<void> call() => repo.signOut();
}
