
import 'package:test_bilimlab_project/data/repository/university_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class UniversityService{

  Future<CustomResponse> getAllUniversity(int page,int size ,{String query = ''}) async {
    return await UniversityRepository().getAllUniversity(page,size,query: query);
  }
  Future<CustomResponse> getUniversityById(int id) async {
    return await UniversityRepository().getUniversityById(id);
  }
}