
import 'dart:io';
import 'dart:typed_data';

import '../../domain/customResponse.dart';
import '../repository/media_repository.dart';

class MediaService{
  Future<Uint8List?> getMediaById(String mediaId) async {
    return await MediaRepository().getMediaById(mediaId);
  }
}