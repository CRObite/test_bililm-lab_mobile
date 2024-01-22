import 'dart:typed_data';

import 'package:test_bilimlab_project/data/service/media_service.dart';

class SetBytes{
  static Future<Uint8List?> setBytes(String id) async {
    Uint8List? bytes =  await MediaService().getMediaById(id);
    return bytes;
  }
}