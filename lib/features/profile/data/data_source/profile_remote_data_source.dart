import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/features/profile/data/models/customer_model.dart';

@lazySingleton
class ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ProfileRemoteDataSource({required this.firestore, required this.auth});

  Future<CustomerModel> getCustomerData({required String customerId}) async {
    final customerDoc = await firestore
        .collection(AppConsts.customersCollection)
        .doc(customerId)
        .get();

    if (!customerDoc.exists || customerDoc.data() == null) {
      throw Exception('Customer not found: $customerId');
    }
    return CustomerModel.fromJson(customerDoc.data()!);
  }
}
