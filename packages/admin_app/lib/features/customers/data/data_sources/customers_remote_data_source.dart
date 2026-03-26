import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/customer_model.dart';

@lazySingleton
class CustomersRemoteDataSource {
  final FirebaseFirestore firestore;

  const CustomersRemoteDataSource({required this.firestore});

  Future<List<CustomerModel>> getCustomers() async {
    final snapshot =
        await firestore.collection(AppConsts.customersCollection).get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      final addresses = data['addresses'] as List<dynamic>? ?? [];
      if (addresses.isNotEmpty) {
        final addr = addresses.firstWhere(
              (a) => (a as Map<String, dynamic>)['isDefault'] == true,
              orElse: () => addresses.first,
            ) as Map<String, dynamic>;
        data['phone'] = addr['phone'] ?? '';
      }
      return CustomerModel.fromJson(data);
    }).toList();
  }
}
