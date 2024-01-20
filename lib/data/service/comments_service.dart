import 'package:test_bilimlab_project/data/repository/comment_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class CommentsService{
  Future<CustomResponse> getCommentsBySpecialization(int id) async {
    return await CommentRepository().getCommentsBySpecialization(id);
  }
  Future<CustomResponse> getCommentsByUniversity(int id) async {
    return await CommentRepository().getCommentsByUniversity(id);
  }
  Future<CustomResponse> getCommentsByPost(int id) async {
    return await CommentRepository().getCommentsByPost(id);
  }
  Future<CustomResponse> getCommentsAnswersById(int id) async {
    return await CommentRepository().getCommentsAnswersById(id);
  }

  Future<CustomResponse> saveComment(int Id, String text,String type) async {
    return await CommentRepository().saveComment(Id, text, type);
  }
}

