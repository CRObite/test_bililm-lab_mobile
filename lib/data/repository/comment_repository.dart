
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/handleErrorResponse.dart';
import 'package:test_bilimlab_project/domain/comment.dart';
import 'package:test_bilimlab_project/domain/commentAnswer.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import '../../domain/currentUser.dart';
import '../../utils/AppApiUrls.dart';

class CommentRepository {

  Dio dio = Dio();

  CommentRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getCommentsByPost(int Id) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getCommentsByPost}$Id',
      );

      List<Comment> comments = (response.data as List<dynamic>)
          .map((commentData) => Comment.fromJson(commentData)).toList();

      return CustomResponse(200, '', comments);
    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getCommentsByUniversity(int Id) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getCommentsByUniversity}$Id',
      );

      List<Comment> comments = (response.data as List<dynamic>)
          .map((commentData) => Comment.fromJson(commentData)).toList();

      return CustomResponse(200, '', comments);
    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getCommentsBySpecialization(int Id) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getCommentsBySpecialization}$Id',
      );

      List<Comment> comments = (response.data as List<dynamic>)
          .map((commentData) => Comment.fromJson(commentData)).toList();

      return CustomResponse(200, '', comments);
    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getCommentsAnswersById(int Id) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getCommentsAnswersById}$Id',
      );

      List<CommentAnswer> commentsAnswers = (response.data as List<dynamic>)
          .map((commentAnswerData) => CommentAnswer.fromJson(commentAnswerData)).toList();

      return CustomResponse(200, '', commentsAnswers);
    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> saveComment(int Id, String text,String type) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.post(
        '${AppApiUrls.saveComment}',
        data:{
          "id": Id,
          "text": text,
          "type": type
        }
      );

      print(response.data);

      return CustomResponse(200, '', null);
    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


}
