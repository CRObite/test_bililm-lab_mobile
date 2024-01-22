import 'package:test_bilimlab_project/data/repository/post_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class PostService{
  Future<CustomResponse> getAllPosts(int page,int size ) async {
    return await PostRepository().getAllPosts(page,size);
  }
  Future<CustomResponse> getPostByID(int id) async {
    return await PostRepository().getPostByID(id);
  }
}