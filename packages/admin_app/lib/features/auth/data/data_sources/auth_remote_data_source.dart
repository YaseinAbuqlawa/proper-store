import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/helpers/app_consts.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';

@lazySingleton
class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const AuthRemoteDataSource({required this.auth, required this.firestore});

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
      throw FirebaseAuthException(code: "user-not-found");
    }

    final uid = user.uid;
    final staffModel = await _fetchStaffModel(uid);

    return staffModel;
  }

  Future<StaffModel> _fetchStaffModel(String uid) async {
    final doc = await firestore
        .collection(AppConsts.staffCollection)
        .doc(uid)
        .get();

    final data = doc.data();

    if (data == null) {
      throw FirebaseAuthException(code: 'not-found');
    }

    return StaffModel.fromJson(data);
  }

  Future<void> signOut() => auth.signOut();
}
