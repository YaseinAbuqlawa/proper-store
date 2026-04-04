import 'package:admin/features/reports/domain/entities/dashboard_stats.dart';
import 'package:admin/features/reports/domain/entities/top_selling_item.dart';
import 'package:admin/features/reports/domain/entities/top_spender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Test the mapping logic directly without Firestore
DashboardStats mapToDashboardStats(Map<String, dynamic> data) {
  final ordersByStatus = (data['ordersByStatus'] as Map<String, dynamic>? ?? {})
      .map((k, v) => MapEntry(k, (v as num).toInt()));

  final dailyRevenue = (data['dailyRevenue'] as Map<String, dynamic>? ?? {})
      .map((k, v) => MapEntry(k, (v as num).toDouble()));

  final monthlyRevenue = (data['monthlyRevenue'] as Map<String, dynamic>? ?? {})
      .map((k, v) => MapEntry(k, (v as num).toDouble()));

  final topSelling = (data['topSelling'] as List<dynamic>? ?? [])
      .map((e) => _mapToTopSellingItem(e as Map<String, dynamic>))
      .toList();

  final topSpenders = (data['topSpenders'] as List<dynamic>? ?? [])
      .map((e) => _mapToTopSpender(e as Map<String, dynamic>))
      .toList();

  final lastUpdatedAt =
      (data['lastUpdatedAt'] as Timestamp?)?.toDate() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  return DashboardStats(
    totalRevenue: (data['totalRevenue'] as num? ?? 0).toDouble(),
    totalOrders: (data['totalOrders'] as num? ?? 0).toInt(),
    totalCustomers: (data['totalCustomers'] as num? ?? 0).toInt(),
    outOfStockCount: (data['outOfStockCount'] as num? ?? 0).toInt(),
    ordersByStatus: ordersByStatus,
    dailyRevenue: dailyRevenue,
    monthlyRevenue: monthlyRevenue,
    topSelling: topSelling,
    topSpenders: topSpenders,
    lastUpdatedAt: lastUpdatedAt,
  );
}

TopSellingItem _mapToTopSellingItem(Map<String, dynamic> data) {
  return TopSellingItem(
    id: data['id'] as String? ?? '',
    productId: data['productId'] as String? ?? '',
    productName: data['productName'] as String? ?? '',
    variantKey: data['variantKey'] as String? ?? '',
    variantName: data['variantName'] as String? ?? '',
    imageUrl: data['imageUrl'] as String? ?? '',
    totalSold: (data['totalSold'] as num? ?? 0).toInt(),
  );
}

TopSpender _mapToTopSpender(Map<String, dynamic> data) {
  return TopSpender(
    customerId: data['customerId'] as String? ?? '',
    name: data['name'] as String? ?? '',
    totalSpent: (data['totalSpent'] as num? ?? 0).toDouble(),
    orderCount: (data['orderCount'] as num? ?? 0).toInt(),
  );
}

void main() {
  test('maps full Firestore document correctly', () {
    final data = <String, dynamic>{
      'totalRevenue': 12500.0,
      'totalOrders': 85,
      'totalCustomers': 40,
      'outOfStockCount': 3,
      'ordersByStatus': {
        'pending': 10,
        'confirmed': 20,
        'shipped': 15,
        'delivered': 40,
        'cancelled': 5,
      },
      'dailyRevenue': {'2026-03-27': 300.0, '2026-03-28': 450.0},
      'monthlyRevenue': {'2026-02': 5000.0, '2026-03': 7500.0},
      'topSelling': [
        {
          'id': 'prod1_red',
          'productId': 'prod1',
          'productName': 'Bag A',
          'variantKey': 'red',
          'variantName': 'Red',
          'imageUrl': 'https://example.com/img.jpg',
          'totalSold': 25,
        },
      ],
      'topSpenders': [
        {
          'customerId': 'cust1',
          'name': 'Ahmed',
          'totalSpent': 2000.0,
          'orderCount': 8,
        },
      ],
      'lastUpdatedAt': null,
    };

    final stats = mapToDashboardStats(data);

    expect(stats.totalRevenue, 12500.0);
    expect(stats.totalOrders, 85);
    expect(stats.totalCustomers, 40);
    expect(stats.outOfStockCount, 3);
    expect(stats.ordersByStatus['confirmed'], 20);
    expect(stats.ordersByStatus['cancelled'], 5);
    expect(stats.dailyRevenue['2026-03-28'], 450.0);
    expect(stats.monthlyRevenue['2026-03'], 7500.0);
    expect(stats.topSelling.length, 1);
    expect(stats.topSelling.first.variantName, 'Red');
    expect(stats.topSelling.first.totalSold, 25);
    expect(stats.topSpenders.length, 1);
    expect(stats.topSpenders.first.name, 'Ahmed');
    expect(stats.topSpenders.first.orderCount, 8);
    expect(stats.aov, closeTo(147.06, 0.1));
    expect(stats.cancellationRate, closeTo(0.0556, 0.001));
  });

  test('handles missing/null fields gracefully', () {
    final stats = mapToDashboardStats({});
    expect(stats.totalRevenue, 0.0);
    expect(stats.totalOrders, 0);
    expect(stats.aov, 0);
    expect(stats.cancellationRate, 0);
    expect(stats.topSelling, isEmpty);
    expect(stats.topSpenders, isEmpty);
  });
}
