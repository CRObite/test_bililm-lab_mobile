import 'package:test_bilimlab_project/data/repository/post_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class PostService{
  Future<CustomResponse> getAllPosts() async {
    return await PostRepository().getAllPosts();
  }
  Future<CustomResponse> getPostByID(int id) async {
    return await PostRepository().getPostByID(id);
  }
}