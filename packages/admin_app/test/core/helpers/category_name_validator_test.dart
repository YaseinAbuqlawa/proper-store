import 'package:admin/core/helpers/category_name_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryNameValidator.normalize', () {
    test('accepts Latin letters, digits, space, underscore, hyphen', () {
      expect(CategoryNameValidator.normalize('Bags 01_new-arrival'),
          'Bags 01_new-arrival');
    });

    test('accepts Arabic letters and spaces', () {
      expect(CategoryNameValidator.normalize('حقائب نسائية'), 'حقائب نسائية');
    });

    test('trims surrounding whitespace', () {
      expect(CategoryNameValidator.normalize('  حقائب  '), 'حقائب');
    });

    test('collapses internal whitespace to single spaces', () {
      expect(
        CategoryNameValidator.normalize('حقائب    نسائية'),
        'حقائب نسائية',
      );
    });

    test('rejects empty and whitespace-only input', () {
      expect(CategoryNameValidator.normalize(''), isNull);
      expect(CategoryNameValidator.normalize('   '), isNull);
    });

    test('rejects path-breaking characters', () {
      expect(CategoryNameValidator.normalize('bags/evil'), isNull);
      expect(CategoryNameValidator.normalize(r'bags\evil'), isNull);
      expect(CategoryNameValidator.normalize('..'), isNull);
    });

    test('rejects control characters', () {
      expect(CategoryNameValidator.normalize('bags\u0000'), isNull);
      expect(CategoryNameValidator.normalize('bags\u001B'), isNull);
    });

    test('rejects emoji and unsupported unicode', () {
      expect(CategoryNameValidator.normalize('bags 😀'), isNull);
    });

    test('rejects punctuation outside the allowlist', () {
      expect(CategoryNameValidator.normalize('bags!'), isNull);
      expect(CategoryNameValidator.normalize('bags.'), isNull);
      expect(CategoryNameValidator.normalize('bags#1'), isNull);
    });

    test('accepts exactly maxLength chars', () {
      final name = 'a' * CategoryNameValidator.maxLength;
      expect(CategoryNameValidator.normalize(name), name);
    });

    test('rejects names longer than maxLength', () {
      final name = 'a' * (CategoryNameValidator.maxLength + 1);
      expect(CategoryNameValidator.normalize(name), isNull);
    });
  });
}
