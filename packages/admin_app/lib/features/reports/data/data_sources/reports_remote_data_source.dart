import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';

import '../models/dashboard_stats_model.dart';
import '../models/out_of_stock_product_model.dart';

@lazySingleton
class ReportsRemoteDataSource {
  final FirebaseFirestore firestore;

  const ReportsRemoteDataSource({required this.firestore});

  Future<DashboardStatsModel> getDashboardStats() async {
    final doc = await firestore
        .collection(AppConsts.statsCollection)
        .doc(AppConsts.dashboardStatsDoc)
        .get();

    final data = doc.data();
    if (data == null) {
      throw FirebaseException(plugin: 'cloud_firestore', code: 'not-found');
    }
    return DashboardStatsModel.fromJson(data);
  }

  Future<List<OutOfStockProductModel>> getOutOfStockProducts() async {
    final snap = await firestore
        .collection(AppConsts.productsCollection)
        .where(AppConsts.hasOutOfStockVariantsField, isEqualTo: true)
        .limit(20)
        .get();

    return snap.docs.map((doc) {
      final data = doc.data();
      return OutOfStockProductModel.fromJson({
        ...data,
        'outOfStockVariants': _resolveVariantNames(data),
      });
    }).toList();
  }

  /// Resolves OOS hex keys to human-readable variant names using the product's
  /// variants map, falling back to the raw hex key if a name is not found.
  static List<String> _resolveVariantNames(Map<String, dynamic> data) {
    final variants = (data['variants'] as Map<String, dynamic>?) ?? {};
    final outOfStock = (data['outOfStockVariants'] as List<dynamic>?) ?? [];
    return outOfStock.map((key) {
      final variant = variants[key as String] as Map<String, dynamic>?;
      return variant?['name'] as String? ?? key;
    }).toList();
  }
}
