import 'dart:typed_data';

import 'package:test_bilimlab_project/data/service/media_service.dart';

class SetBytes{
  static final Map<String, Uint8List> _imageCache = {};

  static Future<Uint8List?> setBytes(String id) async {

    if (_imageCache.containsKey(id)) {
      return _imageCache[id];
    } else {
      Uint8List? bytes = await MediaService().getMediaById(id);
      if (bytes != null) {
        _imageCache[id] = bytes;
      }
      return bytes;
    }
  }


  static void clearImages(){
    _imageCache.clear();
  }
}