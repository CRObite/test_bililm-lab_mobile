
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/handleErrorResponse.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/post.dart';
import 'package:test_bilimlab_project/domain/postItem.dart';
import 'package:test_bilimlab_project/utils/AppApiUrls.dart';

class PostRepository{
  Dio dio = Dio();

  PostRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getAllPosts(int page,int size ) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getAllPosts}',
        queryParameters: {
          'page': page,
          'size': size,
        }
      );
      print(response.data);

      Post posts = Post.fromJson(response.data);

      print(posts);
      return CustomResponse(200, '', posts);
    } catch (e) {
      print('$e');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }
  Future<CustomResponse> getPostByID(int postId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getPostByID}$postId',
      );
      print(response.data);

      PostItem item = PostItem.fromJson(response.data);

      print(item);
      return CustomResponse(200, '', item);
    } catch (e) {
      print('$e');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }
}