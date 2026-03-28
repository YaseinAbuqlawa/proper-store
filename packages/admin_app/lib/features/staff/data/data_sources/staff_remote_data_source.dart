import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StaffRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;

  const StaffRemoteDataSource({
    required this.firestore,
    required this.functions,
  });

  Future<List<StaffListItem>> getStaff() async {
    final snapshot = await firestore.collection('staff').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      final createdAt = data['createdAt'];
      final createdAtDate = createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.fromMillisecondsSinceEpoch((createdAt as int?) ?? 0);
      return StaffListItem(
        uid: doc.id,
        username: data['username'] as String? ?? '',
        role: StaffRole.fromString(data['role'] as String?) ?? StaffRole.cs,
        createdAt: createdAtDate,
      );
    }).toList();
  }

  Future<void> createStaff({
    required String username,
    required String password,
    required StaffRole role,
  }) async {
    await functions.httpsCallable('createStaffAccount').call({
      'username': username,
      'password': password,
      'role': role.name,
    });
  }

  Future<void> changeRole({
    required String uid,
    required StaffRole role,
  }) async {
    await functions.httpsCallable('changeStaffRole').call({
      'uid': uid,
      'role': role.name,
    });
  }

  Future<void> changePassword({
    required String uid,
    required String newPassword,
  }) async {
    await functions.httpsCallable('changeStaffPassword').call({
      'uid': uid,
      'newPassword': newPassword,
    });
  }

  Future<void> deleteStaff(String uid) async {
    await functions.httpsCallable('deleteStaffAccount').call({'uid': uid});
  }
}
