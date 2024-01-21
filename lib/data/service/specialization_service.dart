import 'package:test_bilimlab_project/data/repository/specialization_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class SpecializationService{
  Future<CustomResponse> getAllSpecialization(int id) async {
    return await SpecializationRepository().getAllSpecialization(id);
  }

  Future<CustomResponse> getSpecializationById(int id) async {
    return await SpecializationRepository().getSpecializationById(id);
  }
}