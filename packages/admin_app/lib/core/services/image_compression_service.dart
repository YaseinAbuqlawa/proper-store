import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ImageCompressionService {
  /// Compresses an image to 80% quality with a max width of 1200px.
  Future<Uint8List> compress(Uint8List bytes) async {
    final result = await FlutterImageCompress.compressWithList(
      bytes,
      quality: 80,
      minWidth: 1200,
      minHeight: 1200,
      format: CompressFormat.webp,
    );
    return result;
  }
}
