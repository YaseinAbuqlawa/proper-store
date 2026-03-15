import 'package:flutter_test/flutter_test.dart';
import 'package:proper_store_shared/models/address_model.dart';

void main() {
  const fullJson = <String, dynamic>{
    'id': 'addr-1',
    'label': 'Home',
    'fullName': 'Ahmed Ali',
    'phone': '01012345678',
    'city': 'القاهرة',
    'area': 'المعادي',
    'street': 'شارع 9',
    'buildingNumber': '5',
    'floor': '3',
    'apartment': '12',
    'isDefault': true,
  };

  const model = AddressModel(
    id: 'addr-1',
    label: 'Home',
    fullName: 'Ahmed Ali',
    phone: '01012345678',
    city: 'القاهرة',
    area: 'المعادي',
    street: 'شارع 9',
    buildingNumber: '5',
    floor: '3',
    apartment: '12',
    isDefault: true,
  );

  group('AddressModel.fromJson', () {
    test('maps all fields correctly', () {
      final result = AddressModel.fromJson(fullJson);
      expect(result.id, 'addr-1');
      expect(result.label, 'Home');
      expect(result.fullName, 'Ahmed Ali');
      expect(result.phone, '01012345678');
      expect(result.city, 'القاهرة');
      expect(result.area, 'المعادي');
      expect(result.street, 'شارع 9');
      expect(result.buildingNumber, '5');
      expect(result.floor, '3');
      expect(result.apartment, '12');
      expect(result.isDefault, true);
    });

    test('defaults isDefault to false when key is absent', () {
      final json = Map<String, dynamic>.from(fullJson)..remove('isDefault');
      final result = AddressModel.fromJson(json);
      expect(result.isDefault, false);
    });
  });

  group('AddressModel.toJson', () {
    test('serializes all fields with correct keys', () {
      final json = model.toJson();
      expect(json['id'], 'addr-1');
      expect(json['label'], 'Home');
      expect(json['fullName'], 'Ahmed Ali');
      expect(json['phone'], '01012345678');
      expect(json['city'], 'القاهرة');
      expect(json['area'], 'المعادي');
      expect(json['street'], 'شارع 9');
      expect(json['buildingNumber'], '5');
      expect(json['floor'], '3');
      expect(json['apartment'], '12');
      expect(json['isDefault'], true);
    });

    test('roundtrip: fromJson → toJson produces identical map', () {
      final json = model.toJson();
      final restored = AddressModel.fromJson(json);
      expect(restored, model);
    });
  });

  group('AddressModel.copyWith', () {
    test('produces new instance with changed field', () {
      final updated = model.copyWith(isDefault: false);
      expect(updated.isDefault, false);
      expect(updated.id, model.id);
      expect(updated.label, model.label);
    });
  });
}
