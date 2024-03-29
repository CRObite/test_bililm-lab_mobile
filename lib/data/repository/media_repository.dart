
import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../domain/currentUser.dart';
import '../../utils/AppApiUrls.dart';

class MediaRepository {

  Dio dio = Dio();

  MediaRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<Uint8List?> getMediaById(String mediaId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getMedia}$mediaId',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        Uint8List bytes = Uint8List.fromList(response.data);

        return bytes;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }



}
