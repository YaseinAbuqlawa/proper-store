import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/address_model.dart';

@lazySingleton
class AddressesRemoteDataSource {
  final FirebaseFirestore firestore;

  AddressesRemoteDataSource({required this.firestore});

  DocumentReference<Map<String, dynamic>> _customerRef(String customerId) =>
      firestore.collection(AppConsts.customersCollection).doc(customerId);

  Future<List<AddressModel>> getAddresses({
    required String customerId,
  }) async {
    final doc = await _customerRef(customerId).get();
    if (!doc.exists || doc.data() == null) return [];
    final rawList = doc.data()!['addresses'] as List<dynamic>? ?? [];
    return rawList
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> addAddress({
    required String customerId,
    required AddressModel address,
  }) async {
    if (!address.isDefault) {
      // No default conflict — simple atomic append.
      await _customerRef(customerId).update({
        'addresses': FieldValue.arrayUnion([address.toJson()]),
      });
      return;
    }

    // New address is default: atomically unset all existing defaults,
    // then append the new address in a single transaction.
    await firestore.runTransaction((transaction) async {
      final doc = await transaction.get(_customerRef(customerId));
      final rawList = doc.data()?['addresses'] as List<dynamic>? ?? [];
      final updatedList = [
        ...rawList.map((e) {
          final map = Map<String, dynamic>.from(e as Map<String, dynamic>);
          return {...map, 'isDefault': false};
        }),
        address.toJson(),
      ];
      transaction.update(_customerRef(customerId), {'addresses': updatedList});
    });
  }

  Future<void> deleteAddress({
    required String customerId,
    required AddressModel address,
  }) async {
    await _customerRef(customerId).update({
      'addresses': FieldValue.arrayRemove([address.toJson()]),
    });
  }
}
