
import 'package:test_bilimlab_project/data/repository/university_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class UniversityService{

  Future<CustomResponse> getAllUniversity() async {
    return await UniversityRepository().getAllUniversity();
  }
  Future<CustomResponse> getUniversityById(int id) async {
    return await UniversityRepository().getUniversityById(id);
  }
}