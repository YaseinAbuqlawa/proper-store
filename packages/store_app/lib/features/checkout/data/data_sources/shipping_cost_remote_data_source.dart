import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/shipping_cost_model.dart';

@lazySingleton
class ShippingCostRemoteDataSource {
  final FirebaseFirestore firestore;

  ShippingCostRemoteDataSource({required this.firestore});

  Future<ShippingCostModel> getShippingCost() async {
    final doc = await firestore
        .collection(AppConsts.storeConfigCollection)
        .doc(AppConsts.shippingAreasCostDoc)
        .get();

    if (!doc.exists || doc.data() == null) {
      return const ShippingCostModel(areaCosts: {});
    }
    return ShippingCostModel.fromMap(doc.data()!);
  }
}
