
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/handleErrorResponse.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/post.dart';
import 'package:test_bilimlab_project/utils/AppApiUrls.dart';

class PostRepository{
  Dio dio = Dio();

  PostRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getAllPosts() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getAllPosts}',

      );
      print(response.data['items']);

      List<Post> posts = (response.data['items'] as List<dynamic>)
          .map((postsData) => Post.fromJson(postsData)).toList();

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

      Post post = Post.fromJson(response.data);

      print(post);
      return CustomResponse(200, '', post);
    } catch (e) {
      print('$e');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }
}