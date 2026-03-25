import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressor {
  static const int _maxDimension = 1200;
  static const int _quality = 85;

  // PNG magic number: 8-byte signature
  static bool isPng(Uint8List bytes) =>
      bytes.length >= 8 &&
      bytes[0] == 137 &&
      bytes[1] == 80 &&
      bytes[2] == 78 &&
      bytes[3] == 71;

  static String contentTypeOf(Uint8List bytes) =>
      isPng(bytes) ? 'image/png' : 'image/webp';

  static String extensionOf(Uint8List bytes) =>
      isPng(bytes) ? 'png' : 'webp';

  static Future<Uint8List> compress(Uint8List bytes) async {
    final format = isPng(bytes) ? CompressFormat.png : CompressFormat.webp;
    final result = await FlutterImageCompress.compressWithList(
      bytes,
      minWidth: _maxDimension,
      minHeight: _maxDimension,
      quality: _quality,
      format: format,
    );
    return result;
  }
}
