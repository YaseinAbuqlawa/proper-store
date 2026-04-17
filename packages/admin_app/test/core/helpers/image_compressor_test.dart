import 'dart:typed_data';

import 'package:admin/core/helpers/image_compressor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ImageCompressor.exceedsMaxBytes', () {
    test('returns false at exactly maxBytes', () {
      final bytes = Uint8List(ImageCompressor.maxBytes);
      expect(ImageCompressor.exceedsMaxBytes(bytes), isFalse);
    });

    test('returns true one byte above maxBytes', () {
      final bytes = Uint8List(ImageCompressor.maxBytes + 1);
      expect(ImageCompressor.exceedsMaxBytes(bytes), isTrue);
    });

    test('returns false for empty payload', () {
      expect(ImageCompressor.exceedsMaxBytes(Uint8List(0)), isFalse);
    });
  });
}
