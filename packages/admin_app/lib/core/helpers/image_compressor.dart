import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressor {
  static const int _maxDimension = 1200;
  static const int _quality = 85;

  static Future<Uint8List> compress(Uint8List bytes) async {
    final result = await FlutterImageCompress.compressWithList(
      bytes,
      minWidth: _maxDimension,
      minHeight: _maxDimension,
      quality: _quality,
    );
    return result;
  }
}
